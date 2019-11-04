//
//  SceneDelegate.swift
//  SSKRealmExample
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 SSK. All rights reserved.
//

import UIKit
import RealmSwift


let dbMigrationSchemaVersion: UInt64 = 2

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        
        
        // Coordinator
        // https://www.jianshu.com/p/42766da9578e
        
        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            
             // 不需要做任何事就能完成迁移（比如说删掉了一个属性）

             // 如果需要对新旧模型的值做操作，需要告诉数据库

             // 遍历存储在realm文件中的每一个user对象
             if oldSchemaVersion < 2 {
                 
                 migration.enumerateObjects(ofType: SSKUserInfo.className()) { (oldObject, newObject) in
                     
                     // 新增的属性
                     newObject!["note"] = ""
                 }
             }
            
        }
        
        SSKDatabase.shared.realmConfigure(dbMigrationSchemaVersion, migrationBlock: migrationBlock)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

