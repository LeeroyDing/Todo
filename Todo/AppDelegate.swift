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
    setUpRootViewController()
    return true
  }

}

extension AppDelegate {
  private func setUpRootViewController() {
    guard let rootViewController = window?.rootViewController as? TodoViewController else { fatalError() }
    rootViewController.viewModel = .fake()
  }
}