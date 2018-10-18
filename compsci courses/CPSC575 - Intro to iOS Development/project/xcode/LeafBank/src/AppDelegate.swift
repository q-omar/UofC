//
//  AppDelegate.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-07.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit

import Firebase

@_exported import Sluthware





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	
	
	
	
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
	{
		FirebaseApp.configure()
		
//		let db = Database.database().reference()
//		db.setValue("Hello Firebase")
		print("Application launched successfully.")
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication)
	{
	}
	
	func applicationDidEnterBackground(_ application: UIApplication)
	{
	}
	
	func applicationWillEnterForeground(_ application: UIApplication)
	{
	}
	
	func applicationDidBecomeActive(_ application: UIApplication)
	{
	}
	
	func applicationWillTerminate(_ application: UIApplication)
	{
	}
}




