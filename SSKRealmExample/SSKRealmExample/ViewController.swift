//
//  ViewController.swift
//  SSKRealmExample
//
//  Created by Annieast42 on 2019/10/15.
//  Copyright © 2019 SSK. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
      //  test()
        
        codableExample()
    }

    @IBAction func saveItemAction(_ sender: UIButton) {
        
        let user = SSKUserInfo()
        user.id = "980927"
        user.name = "toom"
        user.age = 34
        
        let annie = SSKUserInfo()
        annie.id = "980933"
        annie.name = "annie"
        annie.age = 42
        
        SSKDatabase.shared.update(user)
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
        
        
        

        
    }
    
    func data<M: Encodable>(from model: M) -> Data {
        
        let encoder = JSONEncoder()
       // encoder.keyEncodingStrategy = .convertToSnakeCase
        return try! encoder.encode(model)
    }
    
    func model<T: Decodable>(_ type: T.Type, from data: Data) -> T {
        let decoder = JSONDecoder()
        return try! decoder.decode(type, from: data)
        
    }
    
}


final class SSKUserInfo: Object {
    
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
        SSKDatabase.shared.add(data)
    }
}


struct Dog: Codable {
    
    var name: String = ""
    
    var age: Int = 0
}

