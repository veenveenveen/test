//
//  UILabel+Extension.swift
//  test
//
//  Created by 黄启明 on 2016/12/2.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(frame: CGRect, text: String) {
        self.init(frame: frame)
        self.text = text
        //以下为默认值
        self.font = UIFont.systemFont(ofSize:22.0, weight: UIFontWeightLight)
        self.textColor = themeTextColor
        self.textAlignment = .center
        self.backgroundColor = UIColor.clear
    }
    
}
