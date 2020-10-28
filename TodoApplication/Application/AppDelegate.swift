//
//  AppDelegate.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 24.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        GIDSignIn.sharedInstance().clientID = "796301433716-0v2oddl0h22o59420anokla69atln9oj.apps.googleusercontent.com"
        AppRouter.runOnLoadFlow()
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { (auth,user) in
            if user != nil {
                AppRouter.runMainFlow()
            }
        }
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

}

