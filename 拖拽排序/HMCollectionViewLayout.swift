//
//  HMCollectionViewLayout.swift
//  test
//
//  Created by 黄启明 on 2016/11/23.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

typealias WidthBlock = (_ indexPath:IndexPath) -> (CGFloat)

class HMCollectionViewLayout: UICollectionViewLayout {

    var widthBlock: WidthBlock?
    
    var colMargin: CGFloat = 8
    var colWidth: CGFloat = 10
    
    let itemHeight: CGFloat = 40
    
    var rightSpace: CGFloat = 0
    var bottomSpace: CGFloat = 0
    
    init(block: WidthBlock?) {
        super.init()
        widthBlock = block
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //布局前的初始工作
    override func prepare() {
        super.prepare()
        rightSpace = 0
        bottomSpace = 0
    }
    //内容尺寸
    override var collectionViewContentSize: CGSize {
        return CGSize(width: screenW, height: bottomSpace+itemHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        var width: CGFloat = 0
        if widthBlock != nil {
            width = widthBlock!(indexPath)
        }
        rightSpace += colWidth
        if rightSpace + width > screenW {
            rightSpace = colWidth
            bottomSpace += itemHeight + self.colMargin;
        }
        attributes.frame = CGRect(x: rightSpace, y: bottomSpace, width: width, height: itemHeight)
        self.rightSpace += width;
        
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var mutArr = Array<UICollectionViewLayoutAttributes>()
        let items = collectionView?.numberOfItems(inSection: 0)
        
        for i in 0..<items! {
            if let att = layoutAttributesForItem(at: IndexPath(item: i, section: 0)) {
                mutArr.append(att)
            }
        }
        return mutArr
    }
    //这个方法是会在cell时重新布局并调用prepareLayout方法
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
