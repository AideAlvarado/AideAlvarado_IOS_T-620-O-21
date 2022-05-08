
import Foundation
import UIKit


//Input protocol
protocol ListTasksRouterInputProtocol{
    func didSelectRow(data:UpdateTimeRecord)
}

final class ListTasksRouter: BaseRouter<ListTasksViewController> {
    var data:ListTasksCoordinatorDTO?
}

extension ListTasksRouter: ListTasksRouterInputProtocol {
    func didSelectRow(data: UpdateTimeRecord) {
        DispatchQueue.main.async {
            debugPrint("-------------")
            debugPrint("Saltando a aprobar el cambio de hora")

            let vc = AprobarCambioCoordinator.view(dto:AprobarCambioCoordinatorDTO(model: data))
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            debugPrint("Saltando a presentacion de Autorizacioin cambio")
            self.viewController?.present(vc,
                                         animated: true,
                                         completion: nil)
  
             }
    }
    
    
}
