//
//  Person.swift
//  TableView
//
//  Created by student on 2018/12/12.
//  Copyright © 2018年 wushan. All rights reserved.
//

import Foundation
enum Gender:Int{    //定义枚举类型性别
    case Male
    case Female
    case Unknow
    static func >(p1:Gender,p2:Gender) -> Bool{
        //定义> 方法判断性别大小
        return p1.rawValue < p2.rawValue
    }
}
class Person{ //Person类
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    var fullName:String {
        //计算属性fullName
        get{
            return firstName + lastName
        }
    }
    init (firstName:String,lastName:String,age:Int,gender:Gender){
        //指定构造函数
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    convenience init(firstName:String,lastName:String){
        //便利构造函数
        self.init(firstName:firstName,lastName:lastName,age:20,gender:Gender.Male)
    }
    func description() -> String{
        //定义函数使其直接用print输出
        return "Name: \(fullName),age:\(age),gender:\(gender)"
    }
    //函数重载使两个Person类的实例对象可以用==和!=比较
    static func ==(per1:Person,per2:Person) -> Bool{
        return per1.fullName==per2.fullName
    }
    static func != (per1:Person,per2:Person) -> Bool{
        return !(per1==per2)
    }
}
var person1 = Person(firstName:"张",lastName:"三",age:18,gender:Gender.Male)
var person2 = Person(firstName:"李",lastName:"小明")

class Student:Person{
    //派生类Student
    var stuNo:Int    //Student属性
    init(stuNo:Int,firstName:String,lastName:String,age:Int,gender:Gender){
        //Student类的初始化
        self.stuNo = stuNo
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    override func description() -> String{
        //重写父类方法
        return "\(super.description()),stuno:\(stuNo)"
    }
}
class Teacher:Person{
    //派生类Teacher
    var title:String    //Teacher属性
    init(firstName:String,lastName:String,age:Int,gender:Gender,title:String){
        //Teacher类的初始化
        self.title = title
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    override func description() -> String{
        //重写父类方法
        return "\(super.description()),title:\(title)"
    }
}
var student1 = Student(stuNo:16001,firstName:"王",lastName:"心",age:21,gender:Gender.Female)
//print(student1.description())
var teacher1 = Teacher(firstName:"周",lastName:"军",age:43,gender:Gender.Male,title:"Math")
//print(teacher1.description())
var student2 = Student(stuNo:16002,firstName:"文",lastName:"阳",age:17,gender:Gender.Male)
var student3 = Student(stuNo:16003,firstName:"赵",lastName:"婷婷",age:20,gender:Gender.Female)
var teacher2 = Teacher(firstName:"邓",lastName:"小利",age:42,gender:Gender.Male,title:"Math")
//建立数组，存放三种对象
var peopleArray = [Person]()



//按年龄age排序
//print("年龄排序如下:")
func sortAge(){
    peopleArray.sort(by:{return $0.age<$1.age})
    for person in peopleArray{
        //遍历输出数组里的对象
        print(person.description())
    }
}

//按fullName排序
func sortFullName(){
    print("fullName排序如下:")
    peopleArray.sort(by:{return $0.fullName<$1.fullName})
    for person in peopleArray{
        //遍历输出数组里的对象
        print(person.description())
    }
}

//按gender+age排序
func sortGAge(){
    print("gender+age排序如下:")
    peopleArray.sort(by:{
        if $0.gender > $1.gender{
            return true
        }else if($0.gender == $1.gender){
            return $0.age > $1.age    //性别相同，按年龄排序
        }else{
            return false
        }
    })
}

