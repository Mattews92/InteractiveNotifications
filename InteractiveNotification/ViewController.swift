//
//  ViewController.swift
//  InteractiveNotification
//
//  Created by Mathews on 08/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        self.authorizeNotifications()
        self.button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonAction() {
        self.label.text = "Move to background to view notification in Notification Center"
        self.scheduleNotification()
    }
}

// MARK: - Schedule Local Notifications
extension ViewController {
    
    /// Request the user to authorize the notifications
    func authorizeNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
            }
        }
    }
    
    /// Scheules a local notification with a textinput, a edit button and a delete button
    /// Local notification is scheduled to fire after 1s
    func scheduleNotification() {
        let reply = UNTextInputNotificationAction(identifier: "text", title: "Reply", options: [], textInputButtonTitle: "Send", textInputPlaceholder: "Message")
        let edit = UNNotificationAction(identifier: "edit", title: "Edit", options: .foreground)
        let delete = UNNotificationAction(identifier: "delete", title: "Delete", options: .destructive)
        let category = UNNotificationCategory(identifier: "com.app.notification", actions: [reply, edit, delete], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Interactive notification"
        notificationContent.subtitle = "Try out new notification"
        notificationContent.body = "New notifications support user interactions"
        notificationContent.categoryIdentifier = "com.app.notification"
        notificationContent.userInfo = ["body": "New notifications support user interactions"]
        if let url = Bundle.main.url(forResource: "puppy", withExtension: "jpg") {
            let attachment =  try! UNNotificationAttachment(identifier: "image", url: url, options: [:])
            notificationContent.attachments = [attachment]
        }
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "com.app.notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let err = error {
                print(err)
            }
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension ViewController: UNUserNotificationCenterDelegate {
    
    /// Delegate invoked when a notification is recieved while the app is foreground
    ///
    /// - Parameters:
    ///   - center: UNUserNotificationCenter instance
    ///   - notification: notification received
    ///   - completionHandler: completion handler determines how to present the received notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        self.label.text = ""
        completionHandler(.alert)
    }
    
    /// Delegate invoked when the app is opened from a notification
    ///
    /// - Parameters:
    ///   - center: UNUserNotificationCenter instance
    ///   - response: notification response
    ///   - completionHandler: completion handler
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        self.label.text = (response.notification.request.content.userInfo["body"] as? String) ?? ""
        completionHandler()
    }
    
}
