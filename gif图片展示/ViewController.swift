//
//  ViewController.swift
//  gif图片展示
//
//  Created by 黄启明 on 2016/11/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import WebKit
import ImageIO

class ViewController: UIViewController {
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    var gifWebView: WKWebView!
    
    var imgArr: Array<CGImage> = []
    var timeArr: Array<NSNumber> = []
    
    var totalTime: Float = 0
    
    var gifView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        showGifWithWebView()
//        showGif()
        let gifView = HMGifView()
        gifView.frame = CGRect(x: (width-60)*0.5, y: (height-60)*0.5, width: 200, height: 200)
        gifView.showGIFImageWithLocalName("fire")
        
        view.addSubview(gifView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //通过帧动画加载GIF
    func showGif() {
        gifView = UIView()
        let gifurl = URL(fileURLWithPath: Bundle.main.path(forResource: "fire", ofType: "gif")!)
        let url: CFURL = gifurl as CFURL
        let gifSource = CGImageSourceCreateWithURL(url, nil)
        let imgCount = CGImageSourceGetCount(gifSource!)
        
        var newWidth: CGFloat = 0
        var newHeght: CGFloat = 0
        
        for i in 0..<imgCount {
            let img = CGImageSourceCreateImageAtIndex(gifSource!, i, nil)
            imgArr.append(img!)
            
            let sourceDict = CGImageSourceCopyPropertiesAtIndex(gifSource!, i, nil) as NSDictionary!
            let gifDict = sourceDict![String(kCGImagePropertyGIFDictionary)] as! NSDictionary
            let time = gifDict[String(kCGImagePropertyGIFUnclampedDelayTime)] as! NSNumber
            print(time)
            timeArr.append(time)
            totalTime += time.floatValue
            
            let imgWidth = sourceDict![String(kCGImagePropertyPixelWidth)] as! NSNumber
            let imgHeight = sourceDict![String(kCGImagePropertyPixelHeight)] as! NSNumber
            if imgWidth.floatValue/imgHeight.floatValue != Float(width/height) {
                if imgWidth.floatValue/imgHeight.floatValue > Float(width/height) {
                    newWidth = width
                    newHeght = width / CGFloat(imgWidth.floatValue/imgHeight.floatValue)
                }
                else {
                    newHeght = height
                    newWidth = height * CGFloat(imgWidth.floatValue/imgHeight.floatValue)
                }
            }
        }
        gifView.frame = CGRect(x: (width-newWidth)*0.5, y: (height-newHeght)*0.5, width: newWidth, height: newHeght)
        startAnim()
        
    }
    
    func startAnim() {
        let anim = CAKeyframeAnimation()
        anim.keyPath = "contents"
        var current: Float = 0
        var timeKeys: Array<NSNumber> = []
        for time in timeArr {
            let timeKey = NSNumber(value: current/totalTime)
            timeKeys.append(timeKey)
            current += time.floatValue
        }
        anim.values = imgArr
        anim.keyTimes = timeKeys
        anim.repeatCount = MAXFLOAT
        anim.duration = TimeInterval(totalTime)
        anim.isRemovedOnCompletion = false
        
        gifView.layer.add(anim, forKey: "HMGifView")
        
        view.addSubview(gifView)
    }
    
    //通过webView加载GIF图片
    func showGifWithWebView() {
        let gifStr = Bundle.main.path(forResource: "fire", ofType: "gif")
        let gifUrl = URL(fileURLWithPath: gifStr!)
        let gifData = try! Data(contentsOf: gifUrl)
        gifWebView = WKWebView()
        gifWebView.frame = view.bounds
        gifWebView.isUserInteractionEnabled = false
        gifWebView.load(gifData, mimeType: "image/gif", characterEncodingName: String(), baseURL: URL(fileURLWithPath: ""))
        view.addSubview(gifWebView)
    }
    
   
}

