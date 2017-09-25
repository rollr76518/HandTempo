//
//  AppDelegate.swift
//  HandTempo
//
//  Created by Ryan on 2017/9/23.
//  Copyright © 2017年 Hanyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if DataManager.shared.customSongs.count == 0 {
            let littleStar = Song.init(name: "小星星", notes:  "31,31,35,35,36,36,35,00,34,34,33,33,32,32,31,00,35,35,34,34,33,33,32,00,35,35,34,34,33,33,32,00,31,31,35,35,36,36,35,00,34,34,33,33,32,32,31,00".separatedToNotes())
            let londonBridge = Song.init(name: "倫敦鐵橋", notes: "35,36,35,34,33,34,35,00,32,33,34,00,33,34,35,00,35,36,35,34,33,34,35,00,32,00,35,00,33,31,00,00,00".separatedToNotes())
            DataManager.shared.save(toUserDefault: littleStar)
            DataManager.shared.save(toUserDefault: londonBridge)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

