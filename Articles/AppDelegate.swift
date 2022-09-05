//
//  AppDelegate.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var coordinator: ArticlesViewCoordinator?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let navController = UINavigationController()
    coordinator = ArticlesViewCoordinator(navigationController: navController)
    coordinator?.start()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    return true
  }
}

