# InteractiveNotifications
<p>

The <b>InteractiveNotifications</b> project provides interactive Push Notifications and enables customisation of the notifications. Customisation requires two of the application extensions viz. <b>Notification Service Extension</b> and <b>Notification Content Extension</b>. Interactive local notifications are also added to the project.
<br>
<h2> How To Add Interactive Remote Notifications To Your Project</h2>
1. Download and use the InteractiveNotifications project frame.
<br>&nbsp&nbsp&nbsp&nbsp Or
<br>
2. Set up interactive notifications in your project.
<br>
In the <i><b>YourProject.xcodeproj</b></i> file, add new targets for the application extensions <b>NotificationServiceExtension</b> and  <b>NotificationContentExtension</b>. Name the targets <i>"NotificationService"</i> and <i>"NotificationContent"</i> respectievely and activate them in the next popup.
<br><img src="/appextension.png"><br>
Now in the project navigator replace the <b><i>NotificationServiceExtension</i></b> directory with the <b><i>NotificationsService directory of InteractiveNotifications</i></b> project. Similarly replace <b><i>NotificationContentExtension</i></b> with the <b><i>NotificationContent directory in the InteractiveNotifications</i></b> project.
<br><br>
Add the <b><i>NotificationDelegate.swift</b></i>, <b><i>URLSessionExtension.swift</b></i> and <b><i>FileManagerExtension.swift</b></i> files to the project and add NotificationService and NotificationContent in the target membership of aall three files.

<h2> Push Notification Payload </h2>
<i>
&nbsp{
<br>&nbsp&nbsp    "aps":{
<br>&nbsp&nbsp&nbsp        "alert":"Custom Push",
<br>&nbsp&nbsp&nbsp        "badge":1,
<br>&nbsp&nbsp&nbsp        "sound":"default",
<br>&nbsp&nbsp&nbsp       "category":"CustomNotification",
<br>&nbsp&nbsp&nbsp        "mutable-content":"1"
<br>&nbsp&nbsp&nbsp    },
<br>&nbsp&nbsp   "imageUrl":"your image url"
<br>&nbsp}
</i>
<br><br>
This payload structure is to be followed in which the category value is to be unchanged. Application matches the category id to customise the notification. Customise the alert field with desired notification message and imageUrl with the desired image url. Use an optimal resolution image so that it can be downloaded in time. Also additional json nodes required by the application may be added to the payload.
<br>
</p>
<h2> How Interactive Remote Notifications Work</h2>
Interactive notifications adds the interactions when it registers for remote notifications. Customisation of the notifications are implemented with the aid of NotificationService and NotificationContent application extensions.
<br><br>
<ul>
<li> The <b><i>NotificationDelegate</b></i> class manages your remote notifications. Invoke this class from the <i>func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool;</i> method of <b>AppDelegate</b> as <b><i>NotificationDelegate.sharedInstance.configureNotification()</i></b> NotificationDelegate requests for push notifications and its UNUserNotificationCenterDelegate methods are invoked when a remote notification is received. Customise these delegates for actions when remote notification is received in the app</li>
<li> The <b><i>URLSession Extension</b></i> provides a custom method to download an Image from a URL</li>
<li> The <b><i>FileManager Extension</b></i> provides a custom method which saves and image from a url to the disk </li>
<li> The <b><i>func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void);</b></i> method in <b><i>NotificationService</b></i> class is invoked when a remote notification is received. An image is added to the notification in this method</li>
<li> The <b><i>func didReceive(_ notification: UNNotification);</b></i> method in the <b><i>NotificationContent</b></i> class is invoked when the notification detail is viewed in the tray. The detail view can be customised from the storyboard file. The notification category is specified in the info.plist file of NotificationContent target which can be employed to customise different notifications differently. Notification payload must use this category id</li>
</ul>

<h2>Interactive Local Notifications</h2>
<p>
Interactive local notifications are configured locally in the <b><i>ViewController</i></b> class. It is scheduled to fire after a delay employing a trigger. Interactive elements and attachments are configured for the notification. The UNUserNotificationCenterDelegate methods can be used to handle the notifications received by the app.
</p>

<h2>More frameworks</h2>
<ul>
<li> Slidermenu for Swift projects <a href=https://github.com/Mattews92/SliderMenu>here</a> </li>
</ul>
