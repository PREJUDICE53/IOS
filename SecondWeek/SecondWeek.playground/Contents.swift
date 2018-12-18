import UIKit
//作业一
//（1）定义字典
var dictionary = [["name":"wushan","age":"21"],["name":"sansa","age":"20"],["name:":"wuxi","age":""]]
//使用map返回age字符串数组,过滤掉age为空的值
var result = dictionary.map{$0["age"] ?? ""}.filter{$0 != ""}
print("age字符串为:")
print(result)
//(2)定义数组string
var string = ["44","ws","33","21","6y","the","21c"]
var intString = string.filter{Int($0) != nil }
print("能够被转换成Int的字符串有\(intString)")
//(3)使用reduce函数连接数组
//$0表示计算后的结果，$1表示数组中的每一个元素
var connectString = string.reduce("",{return $0=="" ? $1 : $0 + "," + $1})
print("连接后的字符串:\(connectString)")
//(4)用 reduce 方法一次求出整数数组的最大值、最小值、总数和
var intArray = [12,4,23,7,14,27,56]
var temp = intArray.reduce((max:Int.min,min:Int.max,sum:0)){(temp,i) in
    return (max(temp.max,i),min(temp.min,i),temp.sum+i)
}
print("数组\(intArray)中:")
print("最大值:\(temp.max)")
print("最小值:\(temp.min)")
print("总数和:\(temp.sum)")
//(5)建立一个函数数组
var funcArray = [Any]()
//定义多个函数，存入数组
func f1(p1:String) -> String{
    return p1
}//函数类型:(String)-> String
func f2(p1:Int) -> Int{
    return p1
}//函数类型:(Int)-> Int
func f3(p1:Float) -> Float{
    return p1
}//函数类型:(Float)-> Float
func f4(p1:Int,p2:Int) -> Int{
    return  p1+p2
}//函数类型:(Int,Int)-> Int
//将函数存入数组
funcArray.append(f1)
funcArray.append(f2)
funcArray.append(f3)
funcArray.append(f4)
for (index,value) in funcArray.enumerated(){
    if value is ((Int) -> Int){
        print("The func \(index) is a type : (Int) -> Int")
    }
}
//(6)扩展Int,增加sqrt方法
extension Int{
    func sqrt(num:Int) -> Double{
        return UIKit.sqrt(Double(num))
    }
}
print(sqrt(16))
//(7)泛型函数找出最大值和最小值
func findMaxandMin<T:Comparable>(data:[T])-> (max:T,min:T){
    var max = data[0]
    var min = data[0]
    for i in data{
        if i>max{
            max = i
        }else if i<min{
            min = i
        }
    }
    return (max,min)
}
//传入整型数值
let dataInt=findMaxandMin(data:[2,5,13,15])
print("整型数值中:最大值为:\(dataInt.max) 最小值为:\(dataInt.min)")
//传入浮点数
let dataFloat=findMaxandMin(data:[2.3,1.6,9,9])
print("浮点数中:最大值为:\(dataFloat.max) 最小值为:\(dataFloat.min)")
//传入字符串
let dataString=findMaxandMin(data:["apple","banana","orange"])
print("字符串中:最大值为:\(dataString.max) 最小值为:\(dataString.min)")

//作业二
enum Gender:Int{    //定义枚举类型性别
    case Male
    case Female
    static func >(p1:Gender,p2:Gender) -> Bool{
        //定义< 方法判断性别大小
        return p1.rawValue < p2.rawValue
    }
}
//department枚举
enum Department:String{
    case student
    case teacher
}
//定义协议
protocol SchoolProtocol{
    var department:Department{get}  //只读属性
    func lendBook()
}
//定义Person类
class Person{
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
    //定义函数使两个Person类的实例对象可以用==和!=比较
    static func ==(per1:Person,per2:Person) -> Bool{
        return per1.fullName==per2.fullName
    }
    static func != (per1:Person,per2:Person) -> Bool{
        return !(per1==per2)
    }
    func run(){
        print("Person \(self.fullName) is Running!")
    }
}
var person1 = Person(firstName:"张",lastName:"三",age:18,gender:Gender.Male)
var person2 = Person(firstName:"李",lastName:"小明")
//person1.run()
//print(person1.description())
//person2.run()
//print(person2.description())

//print("person1等于person2?",person1 == person2)
//print("person1不等于person2?",person1 != person2)
class Student:Person,SchoolProtocol{
    //派生类Student
    var stuNo:String    //Student属性
    var department:Department
    init(firstName:String,lastName:String,age:Int,gender:Gender,stuNo:String){
        //Student类的初始化
        self.stuNo = stuNo
        self.department = Department.student
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    override func description() -> String{
        //重写父类方法
        return "\(super.description()),stuno:\(stuNo)"
    }
    override func run(){
        print("Student \(self.fullName) is Running!")
    }
    func lendBook(){
        print("student \(fullName) can borrow books from library!")
    }
}
class Teacher:Person,SchoolProtocol{
    //派生类Teacher
    var title:String    //Teacher属性
    var department = Department.teacher
    init(firstName:String,lastName:String,age:Int,gender:Gender,title:String){
        //Teacher类的初始化
        self.title = title
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    override func description() -> String{
        //重写父类方法
        return "\(super.description()),title:\(title)"
    }
    override func run(){
        print("Teacher \(self.fullName) is Running!")
    }
    func lendBook(){
        print("Teacher \(fullName) can lend books to library!")
    }
}

var student1 = Student(firstName:"王",lastName:"心",age:21,gender:Gender.Female,stuNo:"16001")
//student1.run()
//print(student1.description())
//student1.lendBook()
var teacher1 = Teacher(firstName:"周",lastName:"军",age:43,gender:Gender.Male,title:"Math")
//teacher1.run()
//print(teacher1.description())
//teacher1.lendBook()
var student2 = Student(firstName:"文",lastName:"阳",age:17,gender:Gender.Male,stuNo:"16002")
var student3 = Student(firstName:"赵",lastName:"婷婷",age:20,gender:Gender.Female,stuNo:"16003")
var teacher2 = Teacher(firstName:"邓",lastName:"小利",age:42,gender:Gender.Male,title:"Math")
//建立数组，存放三种对象
var peopleArray = [Person]()
//将对象追加到数组里
peopleArray.append(person1)
peopleArray.append(person2)
peopleArray.append(student1)
peopleArray.append(student2)
peopleArray.append(student3)
peopleArray.append(teacher1)
peopleArray.append(teacher2)
//穷举,调用run和lendbook
for person in peopleArray{
    person.run()
    if let teacher=person as? Teacher{
        teacher.lendBook()
    }else if let student=person as? Student{
        student.lendBook()
    }
    //print(person.description())
}
//定义字典统计对象个数
var dic:[String:Int] = ["Person":0,"Student":0,"Teacher":0]
for people in peopleArray{
    if people is Teacher{
        dic["Teacher"]! += 1
    }else if people is Student{
        dic["Student"]! += 1
    }else{
        dic["Person"]! += 1
    }
}
//输出字典内容
print("字典内容如下:")
for (key,value) in dic{
    print("\(key):\(value)个")
}
//按年龄age排序
print("年龄排序如下:")
peopleArray.sort(by:{return $0.age<$1.age})
for person in peopleArray{
    //遍历输出数组里的对象
    print(person.description())
}
//按fullName排序
print("fullName排序如下:")
peopleArray.sort(by:{return $0.fullName<$1.fullName})
for person in peopleArray{
    //遍历输出数组里的对象
    print(person.description())
}
//按gender+age排序
print("gender+age排序如下:")
peopleArray.sort(by:{return ($0.age>$1.age) && ($0.gender>$1.gender)})
for person in peopleArray{
    //遍历输出数组里的对象
    print(person.description())
}

