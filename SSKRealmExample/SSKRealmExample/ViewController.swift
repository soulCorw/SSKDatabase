//
//  ViewController.swift
//  SSKRealmExample
//
//  Created by Annieast42 on 2019/10/15.
//  Copyright © 2019 SSK. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
      //  test()
        
        codableExample()
    }

    @IBAction func saveItemAction(_ sender: UIButton) {
        
//        let user = SSKUserInfo()
//        user.id = "980927"
//        user.name = "toom"
//        user.age = 34
//
//        let annie = SSKUserInfo()
//        annie.id = "980933"
//        annie.name = "annie"
//        annie.age = 42
//
//        SSKDatabase.shared.update(user)
        
        
       
        let user = SSKDatabase.shared.object(primaryKey: "980933",
                                             type: SSKUserInfo.self)

        print(user!.name)
        
       // SSKDatabase.shared.update(user)
        //SSKDatabase.shared.update(SSKUserInfo.self, data: user)
//
//
//        SSKUserManager.added(data: user)
        
  
//        if let info = SSKDatabase.shared.first(SSKUserInfo.self) {
//            print(info.id)
//            print(info.name)
//            //info.name = "ANNIE"
//            info.update {
//                info.name = "ANNIE"
//            }
//        }
        

       // SSKDatabase.shared.update(SSKUserInfo.self, keyValues: ["age": 18])
       // query()
    }
    
    
    func query() {
        
        let name = "tom"
        print("name = \(name)")
//        let user = SSKDatabase.shared.object(primaryKeyValue: "tom", type: SSKUserInfo.self)
//        print(user?.name)
        
    }
    
    
    func codableExample() {
        

        let annie = Dog(name: "annie", age: 9)
        
        // 模型转data
        let jsonData = data(from: annie)
        print(jsonData)
        
        
        // data 转模型
        var tom = model(Dog.self, from: jsonData)
        print(tom.name)
        tom.name = "tom"
        print(tom.name)
        
        
        
        let rosy = Student()
        rosy.name = "rosy"
        rosy.id = "120988"
        
        let bookA = Book(id: "101", name: "未来简史", author: "A")
        let bookB = Book(id: "102", name: "独立宣言", author: "B")
        rosy.books.append(bookA)
        rosy.books.append(bookB)
        
        let dataRosy = data(from: rosy)
        
        let stringRosy = String(data: dataRosy, encoding: .utf8)
        print(stringRosy)
        
        
        let rosyModel = model(Student.self, from: dataRosy)
        print(rosyModel.name)
        print(rosyModel.books)
        
        let jsonJack: [String: Any] = [
            "id": "1039",
            /*"name": "Jack",*/
            "age": 100,
            "books": [["id": "987", "name": "to", "author": "h", "website": "https:www.baidu.com"], ["id": "876", "name": "do", "author": "Y"]]
        ]
        
         print(jsonJack)
        
        
        let dataJack = try! JSONSerialization.data(withJSONObject: jsonJack, options: .fragmentsAllowed)
        
        let jack = model(Student.self, from: dataJack)
        print(jack.name)
        print(jack.books)
        
        let book = jack.books.first

        
        if let url = book?.website {
            //let sf = SFSafariViewController(url: url)
            //self.navigationController?.pushViewController(sf, animated: true)
            //self.present(sf, animated: true, completion: nil)
        }
        
        
        
        
        
        
        /*
         模型里面有的属性，json里面必须有，json里有的字段，模型里面可以没有
         如果需要忽略模型里面的某个属性，需要将其声明为可选值(即模型里面有，json里面没有):声明为可选并不是忽略，而是将其赋值为nil
         如果json里的key与模型的属性名不匹配，需要重写CodingKeys手动指定
         
         注：为了防止服务器返回的数据有变化时导致崩溃，建议将模型的属性都声明为可选值，例：当某个属性没有返回时，解析时会给其nil而不是抛出异常
         
        
         
        */
 
       
        

        
    }
    
    func data<T: Encodable>(from model: T) -> Data {
        
        let encoder = JSONEncoder()
       // encoder.keyEncodingStrategy = .convertToSnakeCase
        return try! encoder.encode(model)
    }
    
    func model<T: Decodable>(_ type: T.Type, from data: Data) -> T {
        let decoder = JSONDecoder()
        return try! decoder.decode(type, from: data)
        
    }
    
}


final class SSKUserInfo: Object, Codable {
    
    @objc dynamic var id: String = ""
    
    @objc dynamic var name: String = ""
    
    @objc dynamic var age: Int = 0
    
    @objc dynamic var note: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

final class SSKUserManager: NSObject {
    
    public class func added(data: SSKUserInfo) {
        SSKDatabase.shared.addOrUpdate(data)
    }
}


struct Dog: Codable {
    
    var name: String = ""
    
    var age: Int = 0
    

}


class Student: Codable {
    
    var id: String?
    // 默认值在解码时，如果json的keys里面缺省这个属性，会被重新赋值为nil
    //  忽略某个属性的方法：...
    var name: String? = "tom"
    
    var books: [Book] = []
}

struct Book: Codable {
    var id: String = ""
    var name: String = ""
    var author: String = ""
    
    var website: URL?
}

/*
 
 struct是值类型，在传递和赋值时将会被复制，class是引用类型，只会对同一片空间做引用
 所以struct虽然保证了内存安全但也导致了冗余和碎片化，class则需要对引用做好管理，避免泄漏
 
 
 */
