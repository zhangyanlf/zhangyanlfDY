//
//  AppDelegate.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/27.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }


}

