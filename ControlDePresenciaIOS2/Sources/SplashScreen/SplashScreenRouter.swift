
import Foundation
import UIKit


//Input protocol
protocol SplashScreenRouterInputProtocol{
    func showLogin()
    func showMainMenu()
    func showRegister()
}

final class SplashScreenRouter: BaseRouter<SplashScreenViewController> {
    
}

extension SplashScreenRouter: SplashScreenRouterInputProtocol {
    func showMainMenu() {
        DispatchQueue.main.async {
            let vc = ClockInCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de Main Menu")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    func showLogin() {
        DispatchQueue.main.async {
            let vc = LoginCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de Login")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
        
    }
    
    func showRegister() {
        DispatchQueue.main.async {
            let vc = RegisterCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de Registro")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
}
