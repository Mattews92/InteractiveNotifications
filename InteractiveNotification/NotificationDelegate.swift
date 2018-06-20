//
//  NotificationDelegate.swift
//  InteractiveNotification
//
//  Created by Mathews on 20/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI

class NotificationDelegate: NSObject {
    
    static let sharedInstance = NotificationDelegate()
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
                if granted {
                    let openAction = UNNotificationAction(identifier: "OpenAction", title: "Open", options: .foreground)
                    let editAction = UNNotificationAction(identifier: "EditAction", title: "Edit", options: .foreground)
                    let category = UNNotificationCategory(identifier: "CustomRemoteNotification", actions: [openAction, editAction], intentIdentifiers: [], options: [])
                    UNUserNotificationCenter.current().setNotificationCategories(Set([category]))
                }
                UNUserNotificationCenter.current().delegate = self
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

extension NotificationDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("open")
        case UNNotificationDismissActionIdentifier:
            print("Dismiss")
        default:
            print(response.actionIdentifier)
        }
        completionHandler()    }
}
