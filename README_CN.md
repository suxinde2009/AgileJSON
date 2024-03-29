# 简介 | [Englinsh](./README.md)
AgileJSON是一个用于Swift语言中的JSON序列化/反序列化库。
`AgileJSON`的用法同[`HandyJSON`](https://github.com/alibaba/HandyJSON)基本相似，相较于[`HandyJSON`](https://github.com/alibaba/HandyJSON)直接根据内存布局来解析json，`AgileJSON`更为安全.

# 用法
举个🌰:

```Swift
import UIKit
import AgileJSON

struct StudentInfo: AgileJSONCodable {
    var name = ""
    var Id = ""
}

struct ClassInfo: AgileJSONCodable {
    var name = ""
    var students: [StudentInfo] = []
}

struct Wrapper<T: AgileJSONCodable>: AgileJSONCodable {
    var name = ""
    var param: T?
}

class OperationQueueMgr: NSObject {
    public static let queue = OperationQueue()
}

extension AgileJSONCodable {
    func getWrapper(name: String = "") -> String? {
        let wrapper = Wrapper(name: name, param: self)
        return wrapper.toJSONString()
    }
    
    func printWrapperOnOperationQueue(name: String = "") {
        OperationQueueMgr.queue.addOperation {
            let str = self.getWrapper(name: name)
            print("\(str!)")
        }
    }
    
}

class AgileJSONTestCase: NSObject {
    public static func test() {
        print("\n--------------------- AgileJSON Test Case ---------------------\n")
        
        let student = StudentInfo(name: "name", Id: "342")
        print("\(student.getWrapper(name: "aaa")!)")
        
        var classInfo = ClassInfo()
        classInfo.name = "ss"
        for i in 0...10 {
            let student = StudentInfo(name: "name\(i)", Id: "\(i)")
            classInfo.students.append(student)
        }
        
        let str = classInfo.toJSONString()!
        
        let data = str.data(using: .utf8)
        let decoder = JSONDecoder()
        let clsInfo2: ClassInfo = try! decoder.decode(ClassInfo.self, from: data!)
        
        //print("clsInfo2\(clsInfo2.toJSONString()!)")
        
        
        clsInfo2.printWrapperOnOperationQueue(name: "bbb")
        
        let str3 = "{\"name\":\"bbb\",\"param\":{\"name\":\"ss\",\"students\":[{\"name\":\"name0\",\"Id\":\"0\"},{\"name\":\"name1\",\"Id\":\"1\"},{\"name\":\"name2\",\"Id\":\"2\"},{\"name\":\"name3\",\"Id\":\"3\"},{\"name\":\"name4\",\"Id\":\"4\"},{\"name\":\"name5\",\"Id\":\"5\"},{\"name\":\"name6\",\"Id\":\"6\"},{\"name\":\"name7\",\"Id\":\"7\"},{\"name\":\"name8\",\"Id\":\"8\"},{\"name\":\"name9\",\"Id\":\"9\"},{\"name\":\"name10\",\"Id\":\"10\"}]}}"
        
        let clsInfo3 = Wrapper<ClassInfo>.decodeJSON(from: str3)
        print("\(clsInfo3!.toJSONString()!)")
    }
}



```




