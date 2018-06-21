//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Mathews on 20/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        guard let url = notification.request.content.userInfo["imageUrl"] as? String else {
//            URLSession.downloadImageFrom(url: "https://i.kinja-img.com/gawker-media/image/upload/s--iMQI_iHx--/c_scale,f_auto,fl_progressive,q_80,w_800/bftynezk3phlj4qf0fpm.jpg") { (data) in
//            guard let imageData = data else {
//                return
//            }
//            DispatchQueue.main.async {
//                self.imageView.image = UIImage(data: imageData)
//            }
//            }
            return
        }
        URLSession.downloadImageFrom(url: url) { (data) in
            guard let imageData = data else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }

}
