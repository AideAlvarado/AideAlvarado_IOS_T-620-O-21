//
//  AppDelegate.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: - Variables globales
    var window: UIWindow?
    var appCore: AppCoreCoordinatorProtocol = AppCoreCoordinator()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Inicializamos el entorno de Firebase
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let windowUnw = window {
            self.appCore.initialViewController(window: windowUnw)
        }
       // Theme.defaultTheme()
      return true
    }
}

