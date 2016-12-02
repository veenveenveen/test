//
//  HMNewNoteViewController.swift
//  test
//
//  Created by 黄启明 on 2016/11/30.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class HMNewNoteViewController: UIViewController {

    var textView: HMTextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        setupTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupNavigationUI() {
        //设置 titleView
        navigationItem.titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40), text: "New Note")
        
        let rightButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(doSave))
        rightButton.tintColor = themeTextColor
        navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(doCancel))
        leftButton.tintColor = themeTextColor
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setupTextView() {
        
        textView = HMTextView(frame: view.bounds, textContainer: nil)
        
        //让textview成为第一响应者 进入编辑状态
        textView?.becomeFirstResponder()
        
        textView?.text = ""
        
        view.addSubview(textView!)
    }
    
    func doCancel() {
        print("cancel")
        
        textView?.resignFirstResponder()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func doSave() {
        print("save")
        
        textView?.resignFirstResponder()
        
        _ = navigationController?.popViewController(animated: true)
        //执行保存操作
        //写入数据
        var titleName = "新Note(无内容)"
        if (textView?.text.characters.count)! < showTextCount {
            if (textView?.text.characters.count)! > 0 {
                titleName = (textView?.text)!
            }
        }
        else {
            let index = textView?.text.index((textView?.text.startIndex)!, offsetBy: showTextCount)
            titleName = (textView?.text.substring(to: index!))!
        }
        
//        let str = NSMutableAttributedString(attributedString: (textView?.attributedText)!)
//        let textAttachment = NSTextAttachment(data: nil, ofType: nil)
//        textAttachment.image = UIImage(named: "img.png")
//        let textAttachmentString = NSAttributedString(attachment: textAttachment)
//        str.insert(textAttachmentString, at: 0)
//        textView?.attributedText = str

        HMCoreDataManager.shareManager.addNewItem(title: titleName, details: (textView?.text)!)
    }

}
