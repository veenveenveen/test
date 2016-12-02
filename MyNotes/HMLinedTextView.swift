//
//  HMLinedTextView.swift
//  test
//
//  Created by 黄启明 on 2016/12/2.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class HMLinedTextView: UITextView {
    
    //水平线颜色
    private let horizontalLineColor = UIColor(red: 0.722, green: 0.910, blue: 0.980, alpha: 0.7)
    //竖直线颜色
    private let verticalLineColor = UIColor(red: 0.957, green: 0.416, blue: 0.365, alpha: 0.7)
    
    //内容边距
    private let margins = UIEdgeInsetsMake(0, 17, 0, 5)
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        //设置内容边距
        textContainerInset = margins
        
        textAlignment = .justified
        
        textColor = themeTextColor
        font = textFont
        backgroundColor = UIColor.lightGray
        
        //设置光标颜色
        tintColor = UIColor.orange
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        //绘制水平线
        context?.beginPath()
        context?.setStrokeColor(horizontalLineColor.cgColor)
        
        //两行线之间间隔
        let lineMargin: CGFloat = font!.lineHeight
        
        //线起点与左端的距离
        let boundsX = bounds.origin.x + 7
        //线宽度
        let boundsWidth = bounds.size.width
        
        let lastVisibleLine = Int(bounds.size.height/lineMargin)
        
        for line in 1..<lastVisibleLine {
            let linePointY = lineMargin*CGFloat(line)
            context?.move(to: CGPoint(x: boundsX, y: linePointY))
            context?.addLine(to: CGPoint(x: boundsWidth, y: linePointY))
        }
        //结束绘制水平线
        context?.closePath()
        context?.strokePath()
        
        context?.setLineWidth(1.5)
        //开始绘制 垂直线
        context?.beginPath()
        context?.setStrokeColor(verticalLineColor.cgColor)
        context?.move(to: CGPoint(x: margins.left, y: 0))

        context?.addLine(to: CGPoint(x: margins.left, y: contentOffset.y+bounds.size.height))
        //结束绘制水平线
        context?.closePath()
        context?.strokePath()
        
    }
    
    //自定义光标
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        rect.size.height = (font?.lineHeight)!+2
        rect.size.width = 2
        return rect
    }
    
}
