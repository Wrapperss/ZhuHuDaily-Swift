//
//  AppDelegate.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/6.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //打开调试日志
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "5950b8be766613286700173c"
        self.configUSharePlatforms()
        
        if defaults.object(forKey: "firstLaunch") == nil {
            defaults.set(false, forKey: "firstLaunch")
            defaults.set(false, forKey: "isNight")
            defaults.set(false, forKey: "isPushOn")
        }
        MyThemes.switchNight(isToNight: defaults.object(forKey: "isNight") as! Bool )
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: .alert, completionHandler: { (granted, error) in
                if (error == nil) && granted {
                    print("注册成功")
                }
                else {
                    print("注册失败")
                }
             })
            center.getNotificationSettings(completionHandler: { (settings) in
                print("\(settings)")
            })
        }
        else {
            print("8-10的系统")
        }
        
        
        // navigation bar
        
        let navigationBar = UINavigationBar.appearance()
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        let titleAttributes: [[String: AnyObject]] = globalBarTextColors.map { hexString in
            return [
                NSForegroundColorAttributeName: UIColor(rgba: hexString),
                NSFontAttributeName: UIFont.systemFont(ofSize: 16),
                NSShadowAttributeName: shadow
            ]
        }
        
        navigationBar.theme_tintColor = globalBarTextColorPicker
        navigationBar.theme_barTintColor = globalBarTintColorPicker
        navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithDicts(titleAttributes)
        
        return true
    }

    func configUSharePlatforms() -> Void {
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "1566150867", appSecret: "b853897fc9f6f07ccfdff71e5bf3a43b", redirectURL: "http://wrappers.com")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //收到推送的请求
        let request = response.notification.request
        //收到推送的内容
        let content = request.content
        //收到用户的基本信息
        let userInfo = content.userInfo
        //收到推送消息的角标
        let bage = content.badge
        //收到推送消息body
        let body = content.body
        //推送消息的声音
        //let sound = content.sound
        // 推送消息的副标题
        let subTitle = content.subtitle
        // 推送消息的标题
        let title = content.title
        
        if response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()) == nil {
            print("\(userInfo)\n\(String(describing: bage))\n\(body)\n\(title)\n\(subTitle))")
        }
        
        self.window?.frame = APP_SCREEN
        let mainVC = MainViewController()
        self.window?.rootViewController = UINavigationController.init(rootViewController: mainVC)
        self.window?.makeKeyAndVisible()
        
        completionHandler()
    }
    
    //App处于前台接收通知时
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //收到推送的请求
        let request = notification.request
        //收到推送的内容
        let content = request.content
        //收到用户的基本信息
        let userInfo = content.userInfo
        //收到推送消息的角标
        let bage = content.badge
        //收到推送消息body
        let body = content.body
        //推送消息的声音
        //let sound = content.sound
        // 推送消息的副标题
        let subTitle = content.subtitle
        // 推送消息的标题
        let title = content.title
        
        //不是远程通知
        if notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()) != nil{
            print("\(userInfo)\n\(String(describing: bage))\n\(body)\n\(title)\n\(subTitle))")
        }
        let alert = UNNotificationPresentationOptions.alert
        
        completionHandler(alert)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        return result
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

