//
//  HMGifView.swift
//  test
//
//  Created by 黄启明 on 2016/11/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import ImageIO

class HMGifView: UIView {
    private var width: CGFloat{
        return frame.size.width
    }
    private var height: CGFloat{
        return frame.size.height
    }
    
    private var imgArr: Array<CGImage> = []//保存每一帧图片的数组
    private var timeArr: Array<NSNumber> = []//保存每一帧图片的时间
    
    private var totalTime: Float = 0
    
    func showGIFImageWithLocalName(_ name: String) {
        creatKeyFrameWith(name: name)
    }
    
    private func creatKeyFrameWith(name: String) {
        guard let gifurl = Bundle.main.url(forResource: name, withExtension: "gif") else {
            return
        }
        let url = gifurl as CFURL
        guard let gifSource = CGImageSourceCreateWithURL(url, nil) else {
            return
        }
        let imgCount = CGImageSourceGetCount(gifSource)//获取gif图片个数
        
        for i in 0..<imgCount {
            let img = CGImageSourceCreateImageAtIndex(gifSource, i, nil)
            imgArr.append(img!)
            
            let sourceDict = CGImageSourceCopyPropertiesAtIndex(gifSource, i, nil) as NSDictionary!
            let gifDict = sourceDict![String(kCGImagePropertyGIFDictionary)] as! NSDictionary
            let time = gifDict[String(kCGImagePropertyGIFUnclampedDelayTime)] as! NSNumber
            timeArr.append(time)
            
            totalTime += time.floatValue
            
            let imgWidth = sourceDict![String(kCGImagePropertyPixelWidth)] as! Float
            let imgHeight = sourceDict![String(kCGImagePropertyPixelHeight)] as! Float
            if imgWidth/imgHeight != Float(width/height){
                fitImageSize(imgWidth: imgWidth, imgHeight: imgHeight)
            }
        }
        showAnim()
    }
    
    //根据gif图片大小 调整视图大小
    private func fitImageSize(imgWidth: Float,imgHeight: Float) {
        var newWidth: CGFloat = 0
        var newHeight: CGFloat = 0
        if imgWidth/imgHeight > Float(width/height) {
            newWidth = width
            newHeight = width / CGFloat(imgWidth/imgHeight)
        }
        else {
            newWidth = height * CGFloat(imgWidth/imgHeight)
            newHeight = height
        }
        frame.size = CGSize(width: newWidth, height: newHeight)
    }
    //展示动画
    private func showAnim() {
        let anim = CAKeyframeAnimation()
        
        var current: Float = 0
        var timeKeys: Array<NSNumber> = []
        for time in timeArr {
            let timeKey = NSNumber(value: current/totalTime)
            timeKeys.append(timeKey)
            current += time.floatValue
        }
        
        anim.keyPath = "contents"
        anim.keyTimes = timeKeys
        anim.values = imgArr
        anim.duration = CFTimeInterval(totalTime)
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        
        layer.add(anim, forKey: "HMGifView")
    }
    
}
