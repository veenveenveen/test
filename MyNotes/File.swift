//
//  File.swift
//  test
//
//  Created by 黄启明 on 2016/11/30.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.size.width
let screenH = UIScreen.main.bounds.size.height

//主题字体颜色
let themeTextColor = UIColor.white
let themeBackColor = UIColor.gray

//cell行高
let cellHeight: CGFloat = 55
//section行高
let sectionHeight: CGFloat = 45
//titleLabel显示文本个数
let showTextCount = 25
//编辑文本字体样式
let textFont = UIFont.systemFont(ofSize: 19, weight: UIFontWeightLight)

//是否是新版本
func isNewVersin() -> Bool {
    let key: String = "CFBundleShortVersionString"
    //获取当前应用的版本号
    let infoDict = Bundle.main.infoDictionary
    let app_Version = infoDict?[key] as! String
//    print(app_Version)
    //获取沙盒中存储的应用版本号
    let savedVersion = UserDefaults.standard.object(forKey: key) as? String
//    print(savedVersion)
    if savedVersion != nil && app_Version == savedVersion! {
        return false
    }
    else {
        //保存版本号
        UserDefaults.standard.set(app_Version, forKey: key)
        UserDefaults.standard.synchronize()
        return true
    }
}
//获取当前时间
func currentTime() -> String {
    let currentdate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY年MM月dd日 HH:mm:ss"
    let dateStr = dateFormatter.string(from: currentdate)
    return dateStr
}
//获取日期 用于排序
func getInterval() -> Double {
    let interval: Double = Date().timeIntervalSince1970 as Double
    return interval
}
