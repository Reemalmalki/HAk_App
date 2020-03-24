//
//  AppDelegate.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        print("b4 IsUserSignedIn")
        if UserDefaults.standard.bool(forKey: "IsUserSignedIn") == false {
            print(" IsUserSignedIn = false")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = signInViewController()
            
        } else {
            print(" IsUserSignedIn = true")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "navigationBar")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
            
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    class func setCornerRadiusOf(targetView:UIView, radius:CGFloat) {
        targetView.layer.cornerRadius = radius
        targetView.layer.masksToBounds = true
        
     /*   if needToApplyBorder {
            
            targetView.layer.borderColor = borderColor?.cgColor
            targetView.layer.borderWidth = borderWidth!
        }*/
    }


}

