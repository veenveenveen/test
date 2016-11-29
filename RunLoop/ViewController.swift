//
//  ViewController.swift
//  RunLoop
//
//  Created by 黄启明 on 2016/11/23.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var thread: HMThread?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        if RunLoop.main == RunLoop.current {
//            print("hello")
        }
        
//        creatObserver()
        thread = HMThread(target: self, selector: #selector(test), object: nil)
        thread?.start()
    }
    func test() {
        print(Thread.current)
//        RunLoop.current.add(Port(), forMode: .defaultRunLoopMode)
//        RunLoop.current.run()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            print("hello")
        }
        RunLoop.current.run()
    }
//    func creatObserver() {
//        let observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault() as! CFAllocator!, CFRunLoopActivity.allActivities.rawValue, true, 0) { (observer: CFRunLoopObserver?, activity: CFRunLoopActivity) in
//            print(activity)
//        }
//        
//        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.defaultMode)
//    }
    
    @IBAction func click(_ sender: Any) {
//        print(RunLoop.main)
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
//            print("hello")
//        }
        
        let timer = Timer(timeInterval: 1.0, repeats: true) {(_) in
            print("hello")
        }
        
        RunLoop.current.add(timer, forMode: .commonModes)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        perform(#selector(addImage), with: nil, afterDelay: 2.0, inModes: [RunLoopMode.commonModes])
        perform(#selector(addImage), on: thread!, with: nil, waitUntilDone: false)
    }
    
    func addImage() {
        imgView.image = UIImage(named: "aaa.jpg")
    }

}

