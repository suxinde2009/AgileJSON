//
//  TestCaseFromHandyJSONDemo.swift
//  AgileJSONDemo
//
//  Created by SuXinDe on 2018/10/14.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import UIKit
import AgileJSON

enum Grade: Int, AgileJSONCodable {
    case One = 1
    case Two = 2
    case Three = 3
}

enum Gender: String, AgileJSONCodable {
    case Male = "Male"
    case Female = "Female"
}

struct Teacher: AgileJSONCodable {
    var name: String?
    var age: Int?
    var height: Int?
    var gender: Gender?
}

struct Subject: AgileJSONCodable {
    var name: String?
    var id: Int64?
    var credit: Int?
    var lessonPeriod: Int?
}

class Student: AgileJSONCodable {
    var id: String?
    var name: String?
    var age: Int?
    var grade: Grade = .One
    var height: Int?
    var gender: Gender?
    var className: String?
    var teacher: Teacher = Teacher()
    var subjects: [Subject]?
    var seat: String?
    
    required init() {}
}

class TestCaseFromHandyJSONDemo: NSObject {
    public static func test() {
        print("\n--------------------- TestCase from HandyJSON ---------------------\n")
        print("\n--------------------- serilization ---------------------\n")
        serialization()
        print("\n--------------------- deserilization ---------------------\n")
        deserialization()
    }
    
    fileprivate static func serialization() {
        let student = Student()
        student.name = "Jack"
        student.gender = .Female
        student.subjects = [Subject(name: "Math", id: 1, credit: 23, lessonPeriod: 64), Subject(name: "English", id: 2, credit: 12, lessonPeriod: 32)]
        
        print(student.toJSONObject()!)
        print(student.toJSONString()!)
        //        print(student.toJSONString(prettyPrint: true)!)
        
        //        print([student].toJSONObject())
        //        print([student].toJSONString()!)
    }
    
    fileprivate static func deserialization() {
        let jsonString = "{\"id\":\"77544\",\"json_name\":\"Tom Li\",\"age\":18,\"grade\":2,\"height\":180,\"gender\":\"Female\",\"className\":\"A\",\"teacher\":{\"name\":\"Lucy He\",\"age\":28,\"height\":172,\"gender\":\"Female\",},\"subjects\":[{\"name\":\"math\",\"id\":18000324583,\"credit\":4,\"lessonPeriod\":48},{\"name\":\"computer\",\"id\":18000324584,\"credit\":8,\"lessonPeriod\":64}],\"seat\":\"4-3-23\"}"
        
        if let student = Student.decodeJSON(from: jsonString) {
            print(student.toJSONObject()!)
        }
        
        let arrayJSONString = "[{\"id\":\"77544\",\"json_name\":\"Tom Li\",\"age\":18,\"grade\":2,\"height\":180,\"gender\":\"Female\",\"className\":\"A\",\"teacher\":{\"name\":\"Lucy He\",\"age\":28,\"height\":172,\"gender\":\"Female\",},\"subjects\":[{\"name\":\"math\",\"id\":18000324583,\"credit\":4,\"lessonPeriod\":48},{\"name\":\"computer\",\"id\":18000324584,\"credit\":8,\"lessonPeriod\":64}],\"seat\":\"4-3-23\"}]"
        if let students = [Student].decodeJSON(from: arrayJSONString) {
            print(students.count)
            print(students[0]!.toJSONObject()!)
        }
    }
    
}
