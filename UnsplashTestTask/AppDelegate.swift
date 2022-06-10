//
//  AppDelegate.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 06.06.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        let builder = ModelBuilder()
        let router = Router(tabBarController: tabBarController,
                            builder: builder)
        router.configureViewControllers()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}
