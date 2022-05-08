
import Foundation
import UIKit


//Input protocol
protocol ListUsersRouterInputProtocol{
    func didSelectRowRouter(data:UserRecord)
    func showEditUserDialog(data:UserRecord)
    func goToSplashScreen()
}

final class ListUsersRouter: BaseRouter<ListUsersViewController> {
    
}

extension ListUsersRouter: ListUsersRouterInputProtocol {
    func goToSplashScreen() {
        DispatchQueue.main.async {
            let vc = SplashScreenCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a Splash Screen")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    func didSelectRowRouter(data: UserRecord) {
        //
    }
    
    func showEditUserDialog(data: UserRecord) {
        DispatchQueue.main.async {
            let vc = EditUserCoordinator.view(dto: EditUserCoordinatorDTO(model: data))
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de ")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
            debugPrint("Volviendo de la vista")
        }
    }
    
    
}
