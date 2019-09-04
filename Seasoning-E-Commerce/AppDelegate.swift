//
//  AppDelegate.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/04.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import Ballcap
import Firebase
import GoogleSignIn
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        BallcapApp.configure(Firebase.standardDatastore)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = AuthenticationController.sharedInstance
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        try? Auth.auth().signOut()
    }
}
