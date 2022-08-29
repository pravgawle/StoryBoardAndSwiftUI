//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {
	var window: UIWindow?
	
	// swiftlint:disable:next discouraged_optional_collection
	func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		let window = UIWindow()
		
		self.window = window
		
		let rootNC = UINavigationController(rootViewController: PopularMoviesViewController())
		window.rootViewController = rootNC
		window.makeKeyAndVisible()
		
	//	fatalError("window.rootViewController needs to be set")
	
		return true
	}
}
