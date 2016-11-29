//
//  ViewController.m
//  拖拽排序
//
//  Created by 黄启明 on 2016/11/23.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import "拖拽排序-Swift.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define angle2Radion(angle) (angle / 180.0 * M_PI)

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource, MovingDelegate>

@property (nonatomic, strong) HMCollectionViewLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic,strong)NSMutableArray *heightArr;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSIndexPath * nextIndexPath;
@property (nonatomic,weak) HMCollectionViewCell * originalCell;

@property (nonatomic,strong) UIView * snapshotView; //截屏得到的view

@end

@implementation ViewController

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, screenW, screenH-20) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        //设置代理和数据源
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册cell
        [_collectionView registerClass:[HMCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _collectionView;
}

-(HMCollectionViewLayout *)layout {
    if (!_layout) {
        _layout = [[HMCollectionViewLayout alloc] initWithBlock:^CGFloat(NSIndexPath * _Nonnull indexPath) {
            MovingItem * item = self.array[indexPath.item];
            return item.itemWidth;
        }];
        
    }
    return _layout;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            MovingItem *item = [[MovingItem alloc] init];
            item.title = [NSString stringWithFormat:@"第 %d 个",i];
            item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
            item.itemWidth = 100;
            [_array addObject:item];
        }
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - dataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.delegate = self;
    MovingItem *item = self.array[indexPath.row];
    [cell setCellValueWithItem:item];
    return cell;
}

#pragma mark - MovingDelegate method

- (void)longPressWithLongPress:(UILongPressGestureRecognizer *)longPress {
    
        //记录上一次手势的位置
        static CGPoint startPoint;
        //触发长按手势的cell
        HMCollectionViewCell * cell = (HMCollectionViewCell *)longPress.view;
        
        //开始长按
        if (longPress.state == UIGestureRecognizerStateBegan) {
            
            [self shakeAllCell];
            //获取cell的截图
            _snapshotView  = [cell snapshotViewAfterScreenUpdates:YES];
            _snapshotView.center = cell.center;
            [_collectionView addSubview:_snapshotView];
            _indexPath= [_collectionView indexPathForCell:cell];
            _originalCell = cell;
            _originalCell.hidden = YES;
            startPoint = [longPress locationInView:_collectionView];
            
            //移动
        }else if (longPress.state == UIGestureRecognizerStateChanged){
            
            CGFloat tranX = [longPress locationOfTouch:0 inView:_collectionView].x - startPoint.x;
            CGFloat tranY = [longPress locationOfTouch:0 inView:_collectionView].y - startPoint.y;
            
            //设置截图视图位置
            _snapshotView.center = CGPointApplyAffineTransform(_snapshotView.center, CGAffineTransformMakeTranslation(tranX, tranY));
            startPoint = [longPress locationOfTouch:0 inView:_collectionView];
            //计算截图视图和哪个cell相交
            for (UICollectionViewCell *cell in [_collectionView visibleCells]) {
                //跳过隐藏的cell
                if ([_collectionView indexPathForCell:cell] == _indexPath) {
                    continue;
                }
                //计算中心距
                CGFloat space = sqrtf(pow(_snapshotView.center.x - cell.center.x, 2) + powf(_snapshotView.center.y - cell.center.y, 2));
                
                //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
                if (space <= _snapshotView.bounds.size.width * 0.5 && (fabs(_snapshotView.center.y - cell.center.y) <= _snapshotView.bounds.size.height * 0.5)) {
                    _nextIndexPath = [_collectionView indexPathForCell:cell];
                    if (_nextIndexPath.item > _indexPath.item) {
                        for (NSUInteger i = _indexPath.item; i < _nextIndexPath.item ; i ++) {
                            [self.array exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                        }
                    }else{
                        for (NSUInteger i = _indexPath.item; i > _nextIndexPath.item ; i --) {
                            [self.array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                        }
                    }
                    //移动
                    [_collectionView moveItemAtIndexPath:_indexPath toIndexPath:_nextIndexPath];
                    //设置移动后的起始indexPath
                    _indexPath = _nextIndexPath;
                    break;
                }
            }
            
            //停止
        }else if(longPress.state == UIGestureRecognizerStateEnded){
            
            [self stopShake];
            [_snapshotView removeFromSuperview];
            _originalCell.hidden = NO;
        }
}

#pragma mark - 抖动动画

- (void)shakeAllCell {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@angle2Radion(-5),@angle2Radion(0),@angle2Radion(5),@angle2Radion(0),@angle2Radion(-5)];
    anim.duration = 0.3;
    anim.repeatCount = MAXFLOAT;
    NSArray *cells = [self.collectionView visibleCells];
    for (UICollectionViewCell *cell in cells) {
        /**如果加了shake动画就不用再加了*/
        if (![cell.layer animationForKey:@"shake"]) {
            [cell.layer addAnimation:anim forKey:@"shake"];
        }
    }
}

- (void)stopShake {
    NSArray *cells = [self.collectionView visibleCells];
    for (UICollectionViewCell *cell in cells) {
        [cell.layer removeAllAnimations];
    }
}



@end
