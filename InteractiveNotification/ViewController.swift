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
        self.scheduleNotification()
    }

}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func authorizeNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
            }
        }
    }
    
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
        if let url = Bundle.main.url(forResource: "puppy", withExtension: "jpg") {
            let attachment =  try! UNNotificationAttachment(identifier: "image", url: url, options: [:])
            notificationContent.attachments = [attachment]
        }
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "com.app.notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let err = error {
                print(err)
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print(response)
        completionHandler()
    }
    
}
