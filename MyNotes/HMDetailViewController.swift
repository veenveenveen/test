//
//  HMDetailViewController.swift
//  test
//
//  Created by 黄启明 on 2016/11/30.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

typealias DoCancelBlock = () -> Void
typealias textChangeBlock = () -> Void

class HMDetailViewController: UIViewController, UITextViewDelegate {
    
    var textView: UITextView?
    
    var cancelBlock: DoCancelBlock?
    var textChangeBlock: textChangeBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景色
        view.backgroundColor = UIColor.lightGray
        
        setupNavigationUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupNavigationUI() {
        //设置 titleView
        navigationItem.titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40), text: "详细")
        
        let leftButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(doBack))
        leftButton.tintColor = themeTextColor
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func doBack() {
        print("返回")
        
        _ = navigationController?.popViewController(animated: true)
        
        if cancelBlock != nil {
            cancelBlock!()
        }
        
    }
    
    func setTextForTextView(text: String?) {
        if text != nil {
            
            textView = HMLinedTextView(frame: view.bounds, textContainer: nil)
            textView?.delegate = self
            
            textView?.text = text
            
            view.addSubview(textView!)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //若数据改变 则进入回调 在回调中(修改并保存数据,刷新tableView)
        textChangeBlock!()
    }
}
