//
//  ViewController.swift
//  TableView
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 wushan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView!
    var rightItem: UIBarButtonItem!
    
    var stuArray = [Student]()
    var teaArray = [Teacher]()
    //弹出框
    var alert : UIAlertController!
    //定义表头数组
    var tableTitle = ["Teacher","Student"]
    
    var student1 = Student(stuNo:2016110341,firstName:"wu",lastName:"shan",age:21,gender:Gender.Female)
    var teacher1 = Teacher(firstName:"li",lastName:"guiyang",age:43,gender:Gender.Male,title:"IOS")
    var student2 = Student(stuNo:2016110338,firstName:"wang",lastName:"qing",age:20,gender:Gender.Female)
    var student3 = Student(stuNo:2016110342,firstName:"xia",lastName:"jingwen",age:20,gender:Gender.Female)
    var teacher2 = Teacher(firstName:"li",lastName:"ming",age:40,gender:Gender.Female,title:"Network Security")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Table"
        self.view.backgroundColor = UIColor.lightGray
        stuArray.append(student1)
        stuArray.append(student2)
        stuArray.append(student3)
        teaArray.append(teacher1)
        teaArray.append(teacher2)
        //按全名排序
        func sortTeacher(){
            teaArray.sort(by:{return $0.fullName<$1.fullName})
        }
        func sortStudent(){
            stuArray.sort(by:{return $0.fullName<$1.fullName})
        }
       //创建表视图
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        //导航右边的按钮
        
        rightItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(editClicked))
        self.navigationItem.rightBarButtonItem = rightItem
        
        //导航左边的按钮
        let leftItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addClicked))
        self.navigationItem.leftBarButtonItem = leftItem
      
       
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return teaArray.count
        }else{
            return stuArray.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableTitle[indexPath.section]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil{
            let style : UITableViewCell.CellStyle = (identifier == "Teacher") ? .subtitle : .default
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
       }
        
        switch identifier{
        case "Teacher":
            cell?.textLabel?.text = teaArray[indexPath.row].fullName
            cell?.detailTextLabel?.text = teaArray[indexPath.row].description()
        case "Student":
            cell?.textLabel?.text = stuArray[indexPath.row].fullName
            cell?.detailTextLabel?.text = stuArray[indexPath.row].description()
        default:
            break
        }
        return cell!
    
    }
 
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section{
            tableView.reloadData()
        }else{
            if sourceIndexPath.section == 0{
                teaArray.insert(teaArray.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            }else{
                stuArray.insert(stuArray.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if indexPath.section == 0{
                teaArray.remove(at: indexPath.row)
            }else{
                  stuArray.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }


    
    @objc func addClicked(_ sender: Any) {

        alert = UIAlertController(title: "Add", message: "Student", preferredStyle: .alert)
        alert.addTextField{(textField) in textField.placeholder = "stuNo"}
        alert.addTextField{(textField) in textField.placeholder = "firstname"}
        alert.addTextField{(textField) in textField.placeholder = "lastname"}
        alert.addTextField{(textField) in textField.placeholder = "age"}
        alert.addTextField{(textField) in textField.placeholder = "gender"}
        let okBtn = UIAlertAction(title: "ok", style: .default){
            (alert) in self.add()
        }
        let cancelBtn = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        alert.addAction(cancelBtn)
       self.present(alert, animated: true, completion: nil)
    }
    //添加学生
    func add(){
        let no  =  Int(alert.textFields![0].text!)
        let firstname  = alert.textFields![1].text!
        let lastname  =  alert.textFields![2].text!
        let gender:Gender
        let age = Int(alert.textFields![3].text!)
        switch alert.textFields![4].text!{
        case "male":
            gender = .Male
        case "female":
            gender = .Female
        default:
            gender = .Unknow
        }
        
        let student = Student(stuNo: no!, firstName: firstname, lastName: lastname, age: age!, gender: gender)
        stuArray.append(student)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = tableTitle[indexPath.section]
        
        let name:String
        if indexPath.section == 0{
            name = teaArray[indexPath.row].fullName
        }else{
            name = stuArray[indexPath.row].fullName
        }
        let message = "You selected \(category),name :\(name)"
        let alert = UIAlertController(title: "系统提示", message: message, preferredStyle: .alert)
        let okbtn = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okbtn)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func editClicked(_ sender: Any) {
        if tableView.isEditing{
            rightItem.title = "编辑"
            tableView.isEditing = false
        }else{
            rightItem.title = "完成"
            tableView.isEditing = true
        }
        
    }
}

