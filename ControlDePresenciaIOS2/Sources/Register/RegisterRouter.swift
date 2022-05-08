
import Foundation
import UIKit


//Input protocol
protocol RegisterRouterInputProtocol{
func showMainScreenFromRegister()
}

final class RegisterRouter: BaseRouter<RegisterViewController> {
    
}

extension RegisterRouter: RegisterRouterInputProtocol {
    func showMainScreenFromRegister() {
        DispatchQueue.main.async {
            let vc = ClockInCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de ClockIn")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    
}
