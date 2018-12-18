//
//  MyViewController.swift
//  fiveweek
//
//  Created by student on 2018/11/29.
//  Copyright © 2018年 wushan. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    
    var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.darkGray
        
        imageView = UIImageView(frame: CGRect(x:56,y:90,width:300,height:300))
        imageView.image = UIImage(named: "fayewong")
        
        let label = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 100))
        label.text = "Hello World!"
        label.textAlignment = .center
        label.backgroundColor = UIColor.purple
        label.center = view.center
        view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 40,y: 600,width: 200,height : 50))
        button.setTitle("Show!", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        view.addSubview(button)
        
        let button1 = UIButton(frame: CGRect(x: 200,y: 600,width: 200,height : 50))
        button1.setTitle("Clear!", for: .normal)
        button1.setTitleColor(UIColor.red, for: .normal)
        view.addSubview(button1)
        button1.addTarget(self, action: #selector(btn1Clicked), for: .touchUpInside)
        self.title = "One"
        print("viewdidload")
        
    }
    @objc func btnClicked(){
        if let label = view.subviews.first as? UILabel{
            label.text = "Wow~!"
        }
        view.addSubview(imageView)
    }
    @objc func btn1Clicked(){
        if let label = view.subviews.first as? UILabel{
            label.text = "Thanks~"
        imageView.removeFromSuperview()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
