
import Foundation
import UIKit


//Input protocol
protocol LoginRouterInputProtocol{
    func showMainScreen() }

final class LoginRouter: BaseRouter<LoginViewController> {
    
}

extension LoginRouter: LoginRouterInputProtocol {
    
    func showMainScreen() {
        DispatchQueue.main.async {
            let vc = ClockInCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de ClcokIn")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }}
