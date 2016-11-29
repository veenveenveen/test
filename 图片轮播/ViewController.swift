//
//  ViewController.swift
//  图片轮播
//
//  Created by 黄启明 on 2016/11/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

let imgWidth: CGFloat = UIScreen.main.bounds.size.width
let imgheight: CGFloat = 174
let scrollNumber: Int = 5
let autoScrollInterval: TimeInterval = 2

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var timer: Timer!
    
    var currentIndex: Int = 0
    
    var leftScrollView: UIImageView!
    var centerScrollView: UIImageView!
    var rightScrollView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        //设置分页的个数
        pageControl.numberOfPages = scrollNumber
        //设置当前显示的页
        pageControl.currentPage = 0
        
        setupScrollView()
        
        timer = Timer(timeInterval: autoScrollInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //设置scrollView
    func setupScrollView() {
        //设置contentSize
        scrollView.contentSize = CGSize(width: imgWidth * 3, height: imgheight)
        
        //添加图片 无限轮播
        //设置初始图片
        leftScrollView = UIImageView(image: UIImage(named: "psb_\(scrollNumber-1).jpg"))
        centerScrollView = UIImageView(image: UIImage(named: "psb_\(0).jpg"))
        rightScrollView = UIImageView(image: UIImage(named: "psb_\(1).jpg"))
        
        leftScrollView.frame = CGRect(x: 0, y: 0, width: imgWidth, height: imgheight)
        centerScrollView.frame = CGRect(x: imgWidth, y: 0, width: imgWidth, height: imgheight)
        rightScrollView.frame = CGRect(x: imgWidth * 2, y: 0, width: imgWidth, height: imgheight)
        
        scrollView.addSubview(leftScrollView)
        scrollView.addSubview(centerScrollView)
        scrollView.addSubview(rightScrollView)
        
        scrollView.scrollRectToVisible(centerScrollView.frame, animated: false)
        
        //取消水平指示器
        scrollView.showsHorizontalScrollIndicator = false
        //设置可分页
        scrollView.isPagingEnabled = true
        
    }
    
    func reloadData() {
        var leftIndex = 0
        var rightIndex = 0
        //向右滑动
        if scrollView.contentOffset.x > imgWidth {
            currentIndex = (currentIndex + 1) % scrollNumber
        }
        else if scrollView.contentOffset.x < imgWidth {
            currentIndex = (currentIndex + scrollNumber - 1) % scrollNumber
        }
        
        leftIndex = (currentIndex + scrollNumber - 1) % scrollNumber
        rightIndex = (currentIndex + 1) % scrollNumber
        
        leftScrollView.image = UIImage(named: "psb_\(leftIndex).jpg")
        centerScrollView.image = UIImage(named: "psb_\(currentIndex).jpg")
        rightScrollView.image = UIImage(named: "psb_\(rightIndex).jpg")
    }
    
//MARK: - UIScrollViewDelegate methods
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //停止计时器
        //调用invalidate方法一旦停止计时器，停止以后不可再重用，下次必须重新创建一个新的计时器对象
        if timer != nil {
            timer.invalidate()
        }
        timer = nil
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadData()
        pageControl.currentPage = currentIndex
        self.scrollView.scrollRectToVisible(centerScrollView.frame, animated: false)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //重启定时器
        timer = Timer(timeInterval: autoScrollInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
//MARK: - Timer 方法
    
    func autoScroll() {
        scrollView.scrollRectToVisible(rightScrollView.frame, animated: true)
        let curIndex = (currentIndex + 1) % scrollNumber
        pageControl.currentPage = curIndex
        reloadData()
        scrollView.scrollRectToVisible(centerScrollView.frame, animated: false)
    }
}

