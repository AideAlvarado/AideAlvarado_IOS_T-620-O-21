

import Foundation


// MARK: - module builder

final class RegisterCoordinator {
    static func navigation(dto: RegisterCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: RegisterCoordinatorDTO? = nil) -> RegisterViewController & RegisterPresenterOutputProtocol {
        print(#function)
        let vc = RegisterViewController ()
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: RegisterViewController) -> RegisterPresenterInputProtocol & RegisterInteractorOutputProtocol {
        let presenter = RegisterPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter)
        presenter.router = router(vc: vc)
        return presenter
        
    }
    
    static func interactor(presenter: RegisterPresenter) -> RegisterInteractorInputProtocol {
        let interactor = RegisterInteractor(presenter: presenter)
        return interactor
    }
    static func router(vc: RegisterViewController) -> RegisterRouterInputProtocol {
        let router = RegisterRouter(view: vc)
        return router
    }
}

struct RegisterCoordinatorDTO {
    
}
