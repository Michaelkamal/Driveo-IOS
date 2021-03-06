//
//  AppDelegate.swift
//  Driveo
//
//  Created by Admin on 5/30/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let MAPS_API_KEY:String = "AIzaSyDvzgwC9GUcN9r5mYsfpAQwWXEjh-5_Hy4"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(AppDelegate.MAPS_API_KEY)
        GMSPlacesClient.provideAPIKey(AppDelegate.MAPS_API_KEY)
        IQKeyboardManager.sharedManager().enable = true
       
        
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization( options: [.alert, .badge, .sound], completionHandler: {_, _ in })
        
        let deviceToken = InstanceID.instanceID().token()
        print(" Message \(deviceToken)") // da eb3ato lel firebase w fel refresh token eb3atoo lel back end tany w hen a tav3an hat3ml save fel back userdefaults w lw ma feesh 7aga htb3t lel backend w tsave  gheer kda msh ht3ml kda gheer fel refresh token
        
        application.registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    //MARK: - Open app via link
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool{
        
        if url.host!=="driveo.herokuapp.com" {
            if url.lastPathComponent == "resetpassword"{
               let tokenHash = ((url.query!).split(separator: "="))[1]
                let defaults = UserDefaults.standard
                defaults.set(tokenHash, forKey: "reset_token")
                defaults.synchronize()
                let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
                
                let rpView: ResetPasswordViewController = loginStoryBoard.instantiateViewController(withIdentifier: "resetPassword") as! ResetPasswordViewController
                self.window?.rootViewController = rpView
                self.window?.makeKeyAndVisible()
            }
        }

        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Driveo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //Firebase APNS
    
    @objc func refreshToken(notification: NSNotification) {
        let refreshToken = InstanceID.instanceID().token()
        print(" Message \(refreshToken)")
        fBHandler()
    }
    
    func fBHandler() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // user in the foregorund
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        
        // Print full message.
        print("-----------------------------------------------")
        print("userNotificationCenter , willPresent notification , withCompletionHandler completionHandler")
        print("-----------------------------------------------")
        print(userInfo)
        print("/*/*/*/*/*/*/*/*/*/*/*/*/")
        print(notification.request.content)
        
        ///notificationOnForeground(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    //user in the bg and open the app from the notification itself
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print("-----------------------------------------------")
        print("userNotificationCenter , didReceive response, withCompletionHandler completionHandler")
        print("-----------------------------------------------")
        print(userInfo)
        print("/*/*/*/*/*/*/*/*/*/*/*/*/")
        print(response.notification.request.content)
        print("/*/*/*/*/*/*/*/*/*/*/*/*/")
        
       // notificationOnBackground(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
        print("messaging , didRefreshRegistrationToken")
        print("Firebase token: \(fcmToken)")
        
//        UserDefaultsHandler.cacheObject(fcmToken, forKey: UDK_FBToken)
//        UserDefaultsHandler.removeCachedData(forKey: UDK_FBTokenRegistered)
//        
//        if (TheUserModel.sharedInstance.canLogin){
//            TheUserPresenter.sharedInstance.registerFireBase(FBToken: fcmToken)
//        }
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        print("-----------------------------------------------")
        print("messaging , didReceive remoteMessage")
        print("-----------------------------------------------")
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}

