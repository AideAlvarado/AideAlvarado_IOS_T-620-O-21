

import Foundation


// MARK: - module builder

final class LoginCoordinator {
    static func navigation(dto: LoginCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: LoginCoordinatorDTO? = nil) -> LoginViewController & LoginPresenterOutputProtocol {
        print(#function)
        let vc = LoginViewController ()
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: LoginViewController) -> LoginPresenterInputProtocol & LoginInteractorOutputProtocol {
        let presenter = LoginPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter)
        presenter.router = router(vc: vc)
        return presenter
        
    }
    
    static func interactor(presenter: LoginPresenter) -> LoginInteractorInputProtocol {
        let interactor = LoginInteractor(presenter: presenter)
        return interactor
    }
    static func router(vc: LoginViewController) -> LoginRouterInputProtocol {
        let router = LoginRouter(view: vc)
        return router
    }
}

struct LoginCoordinatorDTO {
    
}
