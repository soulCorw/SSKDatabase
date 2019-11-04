//
//  AppDelegate.swift
//  SSKRealmExample
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 SSK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// https://mmbiz.qpic.cn/mmbiz_jpg/Xy3fkoVasibq9SQ2LVauNaPj1GvkKCKT4xMjQiaaUIBVvEYhQ80jvglsZtDqB2deFsLO3nj2qgc4J6y5w5bvUvvQ/0?wx_fmt=jpeg


/*
 
 
 
 /// 配置数据库
 public class func configRealm() {
     /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
     let dbVersion : UInt64 = 2
     let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
     let dbPath = docPath.appending("/defaultDB.realm")
     let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
         
     }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
     Realm.Configuration.defaultConfiguration = config
     
     Realm.asyncOpen { (realm, error) in
         if let _ = realm {
             print("Realm 服务器配置成功!")
         } else if let error = error {
             print("Realm 数据库配置失败：\(error.localizedDescription)")
         }
     }
     
 }
 
 */
