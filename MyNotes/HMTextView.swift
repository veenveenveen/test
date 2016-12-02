//
//  HMTextView.swift
//  test
//
//  Created by 黄启明 on 2016/11/30.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class HMTextView: HMLinedTextView {

    private var placeLabel: UILabel?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlaceLabel() {
        
        placeLabel = UILabel(frame: CGRect(x: 21, y: 0, width: frame.size.width, height: textFont.lineHeight))
        placeLabel?.backgroundColor = UIColor.clear
        placeLabel?.text = "写点什么吧~"
        placeLabel?.textAlignment = .left
        placeLabel?.font = textFont
        placeLabel?.textColor = UIColor(white: 0.93, alpha: 0.6)
        
        addSubview(placeLabel!)
        //添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: Notification.Name.UITextViewTextDidChange, object: nil)
    }
    
    func textDidChange() {
        placeLabel?.isHidden = hasText
    }
    
    deinit {
        //移出通知
        NotificationCenter.default.removeObserver(self)
    }
}
