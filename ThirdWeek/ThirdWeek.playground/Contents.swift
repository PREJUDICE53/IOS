import UIKit

//定义获取时间的函数
func getDate(date:Date,timezone:Int=0) -> String {
    let formatter = DateFormatter()    //格式化类
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"      //指定格式化格式
    formatter.locale = Locale.current          //设置当前设置，可以输出中文
    if timezone >= 0 {  //当传入的为正数时，在东半区
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(timezone):00")
    } else {  //当传入的为负数时，在西半区
        formatter.timeZone = TimeZone(abbreviation: "UTC\(timezone):00")
    }
    let datemyStr = formatter.string(from: date) //将当前日期转化为字符串返回
    return  datemyStr
}
let currentTime = Date()  //获取当前时间日期
let beijing = getDate(date: currentTime, timezone: +8)  //获取当前北京的时间
print("北京: \(beijing)")
let tokyo = getDate(date: currentTime, timezone: 9)  //获取当前东京的时间
print("东京: \(tokyo)")
let newYork = getDate(date: currentTime, timezone: -5)  //获取当前纽约的时间
print("纽约: \(tokyo)")
let london = getDate(date: currentTime)  //获取当前伦敦的时间
print("伦敦: \(london)")

//2.处理字符串
let myStr = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS.";
print("原字符串:\(myStr)")
let index1 = myStr.index(myStr.startIndex, offsetBy:5)
let index2 = myStr.index(myStr.startIndex, offsetBy:19)
let subStr = myStr[index1...index2]
print("第6个字符到第20个字符的子串为:\n",subStr)
//删除所有OS字符
let str = myStr.replacingOccurrences(of: "OS",with: "")
print("删除后的字符串:\n",str)
//3.存入沙盒文件
//将时间和字符串存入字典
let dic = ["date": ["beijing": beijing, "tokyo": tokyo, "newYork": newYork, "london":london], "string": str] as AnyObject  //将字典转换为任意类型
let filedefault = FileManager.default  //获取默认工作路径
//获取工作路径下的Document文件夹
if var docPath = filedefault.urls(for: .documentDirectory, in: .userDomainMask).first?.path{
    print("默认工作路径为",docPath)
    docPath.append("/test.txt") //新建一个test.txt
    print("是否写入?",dic.write(toFile: docPath, atomically: true)) //将数据写入文件
}
//4.从网上下载照片保存到本地沙盒
let image = try Data(contentsOf: URL(string: "http://img2.imgtn.bdimg.com/it/u=705035102,4031095798&fm=11&gp=0.jpg")!) // 将图片转换为二进制数据
if var url = filedefault.urls(for: .documentDirectory, in: .userDomainMask).first{
    url.appendPathComponent("image.png")
    try image.write(to: url)    //将转换后的二进制数据存为png图片
}
//5.用JSONSerialization和字典进行简单解析
let url = URL(string: "http://www.weather.com.cn/weather/101310201.html")! //三亚天气路径
let data = try Data(contentsOf: url)         //将json数据转换为二进制数据
let jsondata = try JSONSerialization.jsonObject(with: data, options: .allowFragments) //序列化json
//解析jsonhs数据
if let dic = jsondata as? [String: Any]{
    if let weather = dic["weatherinfo"] as? [String: Any]{
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd   = weather["WD"]!
        let ws   = weather["WS"]!
        print("城市：\(city)， 温度：\(temp)， 风向：\(wd)，风力：\(ws)")
    }
}



