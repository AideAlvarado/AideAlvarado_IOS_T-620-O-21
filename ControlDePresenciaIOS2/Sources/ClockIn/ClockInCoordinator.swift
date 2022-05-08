

import Foundation


// MARK: - module builder

final class ClockInCoordinator {
    static func navigation(dto: ClockInCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: ClockInCoordinatorDTO? = nil) -> ClockInViewController & ClockInPresenterOutputProtocol {
        print(#function)
        let vc = ClockInViewController ()
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: ClockInViewController) -> ClockInPresenterInputProtocol & ClockInInteractorOutputProtocol {
        let presenter = ClockInPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter)
        presenter.router = router(vc: vc)
        return presenter
        
    }
    
    static func interactor(presenter: ClockInPresenter) -> ClockInInteractorInputProtocol {
        let interactor = ClockInInteractor(presenter: presenter)
        return interactor
    }
    static func router(vc: ClockInViewController) -> ClockInRouterInputProtocol {
        let router = ClockInRouter(view: vc)
        return router
    }
}

struct ClockInCoordinatorDTO {
    
}
