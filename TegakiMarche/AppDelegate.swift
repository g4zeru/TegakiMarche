//
//  AppDelegate.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/04.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import Firebase
import GoogleSignIn
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ContentDetailsRouter.assembleModules(content: try! Firebase.Content(id: "test", timestamps: Timestamps(createdAt: Date(), updatedAt: Date()), json: ["title":"test", "thumbnail":URL(string: "https://google.com")!, "isPublished": true, "type": "audio"])))
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        try? Auth.auth().signOut()
    }
}
