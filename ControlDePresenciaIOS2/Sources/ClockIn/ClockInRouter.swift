
import Foundation
import UIKit


//Input protocol
protocol ClockInRouterInputProtocol{
    func didSelectRowRouter(data:TimeRecord)
    func showEditDataDialog(data:TimeRecord)
    func showUsersList()
    func showTasksList()
}

final class ClockInRouter: BaseRouter<ClockInViewController> {
    
}

extension ClockInRouter: ClockInRouterInputProtocol {
    func showTasksList() {
        DispatchQueue.main.async {
            let vc = ListTasksCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de lista de tareas")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    func showUsersList() {
        DispatchQueue.main.async {
            let vc = ListUsersCoordinator.view()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de Login")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    func showEditDataDialog(data: TimeRecord) {
        debugPrint(#function)
        debugPrint(data)
        DispatchQueue.main.async {
            let vc = EditTimeCoordinator.view(dto:EditTimeCoordinatorDTO(model: data))
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de Edtit Time")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    func didSelectRowRouter(data: TimeRecord) {
        //Saltar a la vista adecuada para procesar la celda
    }
    
    
}
