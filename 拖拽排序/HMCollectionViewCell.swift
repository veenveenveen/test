//
//  HMCollectionViewCell.swift
//  test
//
//  Created by 黄启明 on 2016/11/23.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

@objc protocol MovingDelegate {
    func longPress(longPress: UILongPressGestureRecognizer)
}

class HMCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var lable: UILabel!
    
    weak var delegate: MovingDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置圆角
        layer.cornerRadius = 3
        layer.masksToBounds = true
        lable = UILabel()
        lable.frame = contentView.frame
        lable.textAlignment = .center
        contentView.addSubview(lable)
        //给每个cell添加一个长按手势
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(longPress:)))
        longPressRecognizer.delegate = self
        addGestureRecognizer(longPressRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func longPressAction(longPress: UILongPressGestureRecognizer) {
        if delegate != nil {
            delegate?.longPress(longPress: longPress)
        }
    }
    
    func setCellValue(item: MovingItem) {
        lable.text = item.title
        backgroundColor = item.backgroundColor
    }
}
