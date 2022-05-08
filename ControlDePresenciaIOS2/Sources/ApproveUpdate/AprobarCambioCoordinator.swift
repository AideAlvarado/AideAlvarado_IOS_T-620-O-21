

import Foundation


// MARK: - module builder

final class AprobarCambioCoordinator {
    static func navigation(dto: AprobarCambioCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view(dto:dto))
    }
    
    static  func view(dto: AprobarCambioCoordinatorDTO? = nil) -> AprobarCambioViewController & AprobarCambioPresenterOutputProtocol {
        print(#function)
        let vc = AprobarCambioViewController ()
        vc.data = dto
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: AprobarCambioViewController, dto:AprobarCambioCoordinatorDTO? = nil) -> AprobarCambioPresenterInputProtocol & AprobarCambioInteractorOutputProtocol {
        let presenter = AprobarCambioPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter, dto:dto)
        presenter.router = router(vc: vc, dto:dto)
        return presenter
        
    }
    
    static func interactor(presenter: AprobarCambioPresenter,dto:AprobarCambioCoordinatorDTO? = nil) -> AprobarCambioInteractorInputProtocol {
        let interactor = AprobarCambioInteractor(presenter: presenter)
        interactor.data = dto
        return interactor
    }
    static func router(vc: AprobarCambioViewController, dto:AprobarCambioCoordinatorDTO? = nil) -> AprobarCambioRouterInputProtocol {
        let router = AprobarCambioRouter(view: vc)
        router.data = dto
        return router
    }
}

struct AprobarCambioCoordinatorDTO {
    var model:UpdateTimeRecord?
}
