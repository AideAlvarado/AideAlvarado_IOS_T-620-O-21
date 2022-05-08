//
//  AppCoreCoordinator.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import UIKit



protocol AppCoreCoordinatorProtocol {
    func initialViewController(window: UIWindow)
}

final class AppCoreCoordinator {
    var actualVC = UIViewController()
}

extension AppCoreCoordinator: AppCoreCoordinatorProtocol {
    func initialViewController(window: UIWindow) {
        debugPrint(#function)
        self.actualVC = SplashScreenCoordinator.view()
        window.rootViewController = self.actualVC
        window.makeKeyAndVisible()
    }
    

}
