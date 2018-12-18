//
//  ViewController.swift
//  ThirteenthWeek-1
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 wushan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //显示计算结果
    var label:UILabel!
    
    //显示主线程现状
    var count = 0
    var timerLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        //点击该按钮进行大数计算ß
        let btn = UIButton(frame: CGRect(x:20, y:100, width: 100, height:40))
        btn.setTitle("开始计算", for:.normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.red, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(startCal), for: .touchUpInside)
        self.view.addSubview(btn)
        
        //显示计算结果
        label = UILabel(frame: CGRect(x: 20, y: 50, width: 300, height: 40))
        label.text="1"
        label.textColor = UIColor.lightGray
        self.view.addSubview(label)
        
        //显示主线程有没有被阻塞
        timerLabel = UILabel(frame: CGRect(x: 10, y: 200, width: 200, height: 100))
        timerLabel.textColor = UIColor.black
        timerLabel.textAlignment = .center
        timerLabel.layer.borderWidth = 1
        timerLabel.font = UIFont.systemFont(ofSize:40)
        self.view.addSubview(timerLabel)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.count += 1
            self.timerLabel.text = "\(self.count)"
            }.fire()
    }
    
    @objc func startCal() {
        //在其他线程中进行计算
        DispatchQueue.global().async {
            var number = 0
            for num in 1...9999999 {
                number += num
                //在主线程中改变label显示的值
                DispatchQueue.main.async {
                    self.label.text = "\(number)"
                }
            }
        }
    }
    
    
}



