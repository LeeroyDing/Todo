//
//  AppDelegate.swift
//  Todo
//
//  Created by Leeroy on 31/12/2015.
//  Copyright © 2015 Leeroy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    seedData()
    window?.rootViewController = rootViewController()
    return true
  }

}

extension AppDelegate {
  private func rootViewController() -> UIViewController {
    let rootViewController = R.storyboard.main.initialViewController!
    let firstViewController = rootViewController.viewControllers.first as! TodoViewController
    firstViewController.viewModel = .fake()
    return rootViewController
  }
}
