//
//  AppDelegate+Push.swift
//  Assureapt
//
//  Created by HET on 2019/12/31.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Firebase

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
}
