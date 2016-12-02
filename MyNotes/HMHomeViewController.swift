//
//  HMHomeViewController.swift
//  test
//
//  Created by 黄启明 on 2016/11/30.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class HMHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    //table view
    private var noteTableView: UITableView!
    
    private var leftButton: UIBarButtonItem!
    //用来判断分组展开与收缩的
    var showDic: [String: String?] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        HMCoreDataManager.shareManager.fetchedResultController.delegate = self
        setupNavigationUI()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//MARK: - 设置Navigation相关属性
    
    private func setupNavigationUI() {
        //设置 titleView
        navigationItem.titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40), text: "MyNotes")
        
        //设置 navigationBar 背景色
        navigationController?.navigationBar.barTintColor = UIColor.gray
        
        //设置 navigationItem
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        rightButton.tintColor = themeTextColor
        navigationItem.rightBarButtonItem = rightButton
        
        leftButton = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(editNotes))
        leftButton.tintColor = themeTextColor
        navigationItem.leftBarButtonItem = leftButton
    }
    
//MARK: - action
    
    //添加新note
    func addNewNote() {
        //跳转到添加界面
        let new = HMNewNoteViewController()
        navigationController?.pushViewController(new, animated: true)
        
        //若正处在编辑状态 则取消编辑
        editDone()
    }
    //编辑
    func editNotes() {
        print("edit")
        noteTableView.setEditing(true, animated: true)
        
        //修改为完成按钮
        modifyLeftButtonWith(title: "完成", action: #selector(editDone))
    }
    //编辑完成
    func editDone() {
        noteTableView.setEditing(false, animated: true)
        
        //恢复编辑按钮
        modifyLeftButtonWith(title: "编辑", action: #selector(editNotes))
    }
    
    func modifyLeftButtonWith(title: String, action: Selector) {
        leftButton.title = title
        leftButton.action = action
    }
    
//MARK: - 设置 tableView
    
    private func setupTableView() {
        noteTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), style: .plain)
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.register(HMTableViewCell.self, forCellReuseIdentifier: "cell_ID")
        noteTableView.rowHeight = cellHeight
        view.addSubview(noteTableView)
    }
    
//MARK: - tableView dataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        if (HMCoreDataManager.shareManager.fetchedResultController.sections?.count)! > 0 {
//            return HMCoreDataManager.shareManager.fetchedResultController.sections!.count
//        }
//        else {
//            return 1
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (HMCoreDataManager.shareManager.fetchedResultController.sections?.count)! > 0 {
            return HMCoreDataManager.shareManager.fetchedResultController.sections![section].numberOfObjects
        }
        else {
            print("fetchedResultController.sections?.count)! = 0")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = HMCoreDataManager.shareManager.fetchedResultController.object(at: indexPath) as! Note
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID", for: indexPath) as! HMTableViewCell
        cell.note = note
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: sectionHeight))
        headerView.backgroundColor = UIColor.orange
        let myLabel = UILabel(frame: CGRect(x: 10, y: 5, width: screenW-20, height: sectionHeight-2*5))
        
        if let noteSection = HMCoreDataManager.shareManager.fetchedResultController.sections?[section] {
            myLabel.text = noteSection.name
        }
        
        myLabel.textAlignment = .left
        myLabel.textColor = UIColor.white
        headerView.addSubview(myLabel)
        
        headerView.tag = section
        
        //添加单击的 Recognizer ,收缩分组cell
        let singleRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap(recognizer:)))
        singleRecognizer.numberOfTapsRequired = 1//点击次数
        singleRecognizer.numberOfTouchesRequired = 1//几个手指操作
        headerView.addGestureRecognizer(singleRecognizer)//添加一个手势检测
        
        return headerView
    }
    */
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if showDic["\(indexPath.section)"] ?? "0" == "1" {
//            print("hello it's my trun")
//            return cellHeight
//        }
//        else {
//            return 0
//        }
//    }

//MARK: - tableView delegate methods
    
    //设置cell可编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //定义编辑的样式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        //修改为完成按钮
        modifyLeftButtonWith(title: "完成", action: #selector(editDone))
        return UITableViewCellEditingStyle.delete
    }
    //进入编辑模式 点击相应的按钮后 进行操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //coreData中删除
            HMCoreDataManager.shareManager.deleteItemAtIndexPath(indexPath)
            //tableView中删除
            noteTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //结束编辑
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        //修改为编辑按钮
        modifyLeftButtonWith(title: "编辑", action: #selector(editNotes))
    }
    //修改删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    //选中某行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转到详细界面
        let detail = HMDetailViewController()
        let note = HMCoreDataManager.shareManager.fetchedResultController.object(at: indexPath) as! Note
        detail.setTextForTextView(text: note.details)
        
        weak var wself = self
        detail.textChangeBlock = {
            var titleName = "新Note(无内容)"
            if (detail.textView?.text.characters.count)! < showTextCount {
                if (detail.textView?.text.characters.count)! > 0 {
                    titleName = (detail.textView?.text)!
                }
            }
            else {
                let index = detail.textView?.text.index((detail.textView?.text.startIndex)!, offsetBy: showTextCount)
                titleName = (detail.textView?.text.substring(to: index!))!
            }
            //修改并保存数据
            note.title = titleName
            note.details = detail.textView?.text
            note.creatTime = currentTime()
            note.intervalFlag = getInterval()

            HMCoreDataManager.shareManager.saveContext()
            //文本改变刷新数据
            wself?.noteTableView.reloadData()
        }
        detail.cancelBlock = {
            //取消选中 block回调 ，因进入详情页没有任何操作 则不刷新数据 直接取消 什么也不做
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
        
        navigationController?.pushViewController(detail, animated: true)
    }
    
//MARK: - NSFetchedResultsControllerDelegate methods
    
    //数据 section 改变状况
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            print("section insert")
        case .delete:
            print("section delete")
//            noteTableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            print("section move")
        case .update:
            print("section update")
        }
    }
    //数据改变状况
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            print("object insert")
            //数据库中插入数据成功后 刷新tableview
//            noteTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            noteTableView.reloadData()
        case .delete:
            print("object delete")
        case .move:
            print("object move")
        case .update:
            print("object update")
        }
        
    }
    
//MARK: 手势点击事件
    func singleTap(recognizer: UIGestureRecognizer) {
        let selectedSection = recognizer.view?.tag
        print("ssssssss\(selectedSection)")
        let key = "\(selectedSection)"
        if showDic[key] ?? "0" == "0" {
            showDic[key] = "1"
            print("1")
        }
        else {
            showDic[key] = "0"
            print("0")
        }
        
        print(IndexSet(integer: selectedSection!))
        noteTableView.reloadSections(IndexSet(integer: selectedSection!), with: UITableViewRowAnimation.fade)
    }
    
}
