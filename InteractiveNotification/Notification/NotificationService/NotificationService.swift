//
//  NotificationService.swift
//  NotificationService
//
//  Created by Mathews on 20/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            guard let imageUrl = request.content.userInfo["imageUrl"] as? String else {
                contentHandler(bestAttemptContent)
                return
            }
            
            // Download the image from URL and save it to Disk
            // Create a UNNotificationAttachment with the saved file
            // Add the UNNotificationAttachment to the BestAttemptContent notification request
            if let imageFileUrl = FileManager.saveImageFrom(urlString: imageUrl) {
                if let attachment = try? UNNotificationAttachment(identifier: "notificationImage", url: imageFileUrl, options: nil) {
                    bestAttemptContent.attachments = [attachment]
                }
            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
