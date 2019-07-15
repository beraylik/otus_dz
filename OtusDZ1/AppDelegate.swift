//
//  AppDelegate.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 03/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }

}

// Extension for open with URL handling
extension AppDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "OtusDzUrl" {
            switch url.host {
            case "LocalizeSharedVC":
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "LocalizeSharedExt", bundle: nil)
                let localizeSharedVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LocalizeSharedVC") as UIViewController
                
                let navigationController = UINavigationController(rootViewController: localizeSharedVC)
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            default:
                break
            }
        }
        return true
    }
    
}
