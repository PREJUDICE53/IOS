import UIKit
//作业一
//找出1-10000的所有质数的函数
func findPrimeNum() -> [Int] {
    var primeArray = [2,3]   //定义可变数组存放质数,2，3为质数先存入数组
    var isPrime = 0       //定义变量判断是否为质数
    for x in 4...10000{         //从4开始判断
        for y in 2..<x {
            if x%y==0{
                isPrime += 1  //找到一个除自己以外的因数，就退出，进行下一个的判断
                break
            }
        }
        if isPrime==0 {
            primeArray.append(x) //存入质数数组
        }
        isPrime = 0;
    }
    return primeArray   //返回数组
}
//对数组进行排序
var primeNum = findPrimeNum()
primeNum.sort()
print("数组升序排序结果为:")
print(primeNum)
//第一种降序
func compare(m:Int,n:Int) -> Bool{
    return m > n
}
primeNum.sort(by: compare)
print("数组第一种降序排序结果为:")
print(primeNum)
//第二种降序
primeNum.sort(by:{(m:Int,n:Int) -> Bool in
    return m > n
})
print("数组第二种降序排序结果为:")
print(primeNum)
//第三种降序
primeNum.sort(by:{(m,n) -> Bool in
    return m > n
})
print("数组第三种降序排序结果为:")
print(primeNum)
//第四种降序
primeNum.sort{(m,n) in
    return m > n
}
print("数组第四种降序排序结果为:")
print(primeNum)
//第五种降序
primeNum.sort(by:>)
print("数组第五种降序排序结果为:")
print(primeNum)
//第六种降序
primeNum.sort{$0>$1}
print("数组第六种降序排序结果为:")
print(primeNum)

//作业二
enum Gender:Int{    //定义枚举类型性别
    case Male
    case Female
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
print(person1.description())
print(person2.description())
print("person1等于person2?",person1 == person2)
print("person1不等于person2?",person1 != person2)
class Student:Person{
    //派生类Student
    var stuNo:String    //Student属性
    init(firstName:String,lastName:String,age:Int,gender:Gender,stuNo:String){
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
var student1 = Student(firstName:"王",lastName:"心",age:21,gender:Gender.Female,stuNo:"16001")
//print(student1.description())
var teacher1 = Teacher(firstName:"周",lastName:"军",age:43,gender:Gender.Male,title:"Math")
//print(teacher1.description())
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
for person in peopleArray{
    //遍历输出数组里的对象
    print(person.description())
}
//定义字典统计对象个数
var dictionary = ["Person":0,"Student":0,"Teacher":0]
for people in peopleArray{
    if people is Teacher{
        dictionary["Teacher"]! += 1
    }else if people is Student{
        dictionary["Student"]! += 1
    }else{
        dictionary["Person"]! += 1
    }
}
//输出字典内容
print("字典内容如下:")
for (key,value) in dictionary{
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
peopleArray.sort(by:{
    if $0.gender > $1.gender{
        return true
    }else if($0.gender == $1.gender){
        return $0.age > $1.age    //性别相同，按年龄排序
    }else{
        return false
    }
})
for person in peopleArray{
    //遍历输出数组里的对象
    print(person.description())
}

