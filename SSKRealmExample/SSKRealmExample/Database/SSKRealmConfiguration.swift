//
//  EPRealmConfiguration.swift
//  EOSPocket
//
//  Created by LiuYing on 2019/1/25.
//  Copyright © 2019 SSK. All rights reserved.
//

// iOS Realm简单使用(增删改查和排序) https://www.jianshu.com/p/4f08131f2a29
// 移动端iOS系统数据库之Realm(二)表的创建增删改查  https://www.jianshu.com/p/48910e88e8a1
// 官方文档 https://realm.io/cn/docs/swift/latest/

// Realm的坑：不自动删除关联的子表

import Foundation
import RealmSwift


public final class SSKDatabase {
    
    private init() {}
    
    public class var shared: SSKDatabase {
        struct Singleton {
            static let instance = SSKDatabase()
        }
        return Singleton.instance
    }
    
    // realm
    private(set) var sharedRealm: Realm!
    
    fileprivate  var shareConfig: Realm.Configuration!

    
    public func realmConfigure(_ schemaVersion: UInt64 = 0, migrationBlock: MigrationBlock?) {
        
        do {

            let config = SSKRealmConfiguration.sharedConfiguration(schemaVersion, migrationBlock: migrationBlock)
            shareConfig = config
             self.sharedRealm = try Realm(configuration: config)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        print(sharedRealm.configuration)
        
    }
    
    // 删除数据库文件
    public func deleteRealm() {
        
        if let path = shareConfig.fileURL {
            
            do {
                try FileManager.default.removeItem(at: path)
            } catch {
                print("Error: [ deleteRealm: FileManager.default.removeItem(at: path!) ]")
            }
        }
        
    }
    
    ///  清空整个数据库
    public func cleanRealm() {
        self.sharedRealm.deleteAll()
    }
    

    
}

struct SSKRealmConfiguration {
    
    static func sharedConfiguration(_ schemaVersion: UInt64,
                                    migrationBlock: MigrationBlock?) -> Realm.Configuration {
        let config = Realm.Configuration()
        
        // 获取realm默认的文件路径，并自定义realm文件名
        let directory = config.fileURL!.deletingLastPathComponent()
        let url = directory.appendingPathComponent("shared.realm")
        

        // 生成新的 config
        var realmConfig = Realm.Configuration(fileURL: url)
        
        debugPrint(url)
        realmConfig.schemaVersion = schemaVersion
        

        // 当前schemaVersion大于上一次设置的schemaVersion, migrationBlock才会被执行
        realmConfig.migrationBlock = migrationBlock
        
        
        Realm.Configuration.defaultConfiguration = realmConfig
        debugPrint(realmConfig.schemaVersion)
        
        return realmConfig
    }
    
    
    
    // https://www.jianshu.com/p/95b384eefc01
    // https://www.jianshu.com/p/46d70d5409e1
    
    
    // https://www.cnblogs.com/h-tao/p/7130416.html
    
    // https://www.jianshu.com/p/6cefba76d0ad
    
    
    // https://www.jianshu.com/p/e7b467620379
}

public extension SSKDatabase {
    
    func add(_ data: Object) {
        try! sharedRealm.write {
            // 和 （func update(_ data: Object)） 等价
            sharedRealm.add(data, update: Realm.UpdatePolicy.modified)
        }
    }
    
    // where: 限定元素类型
    /// 批量添加对象
    func add<S: Sequence>(objects: S) where S.Iterator.Element: Object {
        try! sharedRealm.write {
            sharedRealm.add(objects, update: Realm.UpdatePolicy.modified)
        }
    }
    
    /// 直接更新一个对象的属性
    func update(_ block: (() -> Void)) {
        try! sharedRealm.write {
            block()
        }
    }
    
    /// 批量更新一张表里面的对象
    func update<Element: Object>(_ type: Element.Type, keyValues: [String: Any]) {
        
        let objects = sharedRealm.objects(type)
        guard objects.count > 0 else { return }
        
        try! sharedRealm.write {
            keyValues.forEach { (key, value) in
                objects.setValue(value, forKey: key)
            }
            
        }
        
    }
    
    /// 通过主键更新一个对象
    func update(_ data: Object) {
        
        // 主键之外的属性全部更新,如果没有此主键会创建一个新对象(此方法和add等价)
        try! sharedRealm.write {
            sharedRealm.add(data, update: Realm.UpdatePolicy.modified)
            
        }
    }
    
    
    /// 通过主键更新对称的部分属性
    
    /**
     
        T：类型约束
        更新部分属性
     
        - parameter data: 建议用字典（必须包含主键）
        
     */
    func update<T: Object>(_ type: T.Type, data: Any = [:]) {
        try! sharedRealm.write {
            sharedRealm.create(type, value: data, update: Realm.UpdatePolicy.modified)
        }
    }
    
    // 删除某张表(a class is a table)
    func delete<Element: Object>(_ type: Element.Type) {
        
        let objects = sharedRealm.objects(type)
        
        try! sharedRealm.write {
            sharedRealm.delete(objects)
            
        }
    }
    
    // 删除某个对象
    func delete(_ obj: Object) {
        
        try! sharedRealm.write {
            sharedRealm.delete(obj)
        }
    }
    
    // 获取某张表(a class is a table)的所有对象
    func objects<Element: Object>(for type: Element.Type) -> Results<Element> {
        return sharedRealm.objects(type)
    }
    
    // 获取某张表里的第一个元素
    func first<Element: Object>(_ type: Element.Type) -> Element? {
        return objects(for: type).first
    }
    
    // 获取某张表里的最后一个元素
    func last<Element: Object>(_ type: Element.Type) -> Element? {
        return objects(for: type).last
    }
    
    // 获取某张表里指定index的元素 【存储是否有序待验证】
    func object<Element: Object>(_ type: Element.Type, index: Int) -> Element? {
        guard index >= 0 else { print("error: index must >= 0"); return nil }
        
        
        let elements = objects(for: type)
        
        if elements.count < index {
            return elements[index]
        }
        
        return nil
    }
    
    /// 存储的对象必须重写 primaryKey()
    func object<Element: Object>(primaryKey: String, type: Element.Type) -> Element?  {
        return sharedRealm.object(ofType: type, forPrimaryKey: primaryKey)
    }
   

}


public extension Object {
    
    class func object(for primaryKeyValue: String) {
        
    }
    
     /// 直接更新一个对象的属性
    func update(_ block: (() -> Void)) {
        
 
        try! SSKDatabase.shared.sharedRealm.write {
            block()
        }
    }
}
