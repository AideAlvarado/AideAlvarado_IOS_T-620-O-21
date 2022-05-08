

import Foundation


// MARK: - module builder

final class SplashScreenCoordinator {
    static func navigation(dto: SplashScreenCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: SplashScreenCoordinatorDTO? = nil) -> SplashScreenViewController & SplashScreenPresenterOutputProtocol {
        print(#function)
        let vc = SplashScreenViewController ()
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: SplashScreenViewController) -> SplashScreenPresenterInputProtocol & SplashScreenInteractorOutputProtocol {
        let presenter = SplashScreenPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter)
        presenter.router = router(vc: vc)
        return presenter
        
    }
    
    static func interactor(presenter: SplashScreenPresenter) -> SplashScreenInteractorInputProtocol {
        let interactor = SplashScreenInteractor(presenter: presenter)
        return interactor
    }
    static func router(vc: SplashScreenViewController) -> SplashScreenRouterInputProtocol {
        let router = SplashScreenRouter(view: vc)
        return router
    }
}

struct SplashScreenCoordinatorDTO {
    
}
