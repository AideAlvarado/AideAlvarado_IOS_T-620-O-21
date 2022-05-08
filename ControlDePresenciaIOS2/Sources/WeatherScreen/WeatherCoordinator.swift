

import Foundation


// MARK: - module builder

final class WeatherCoordinator {
    static func navigation(dto: WeatherCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: WeatherCoordinatorDTO? = nil) -> WeatherViewController & WeatherPresenterOutputProtocol {
        print(#function)
        let vc = WeatherViewController ()
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: WeatherViewController) -> WeatherPresenterInputProtocol & WeatherInteractorOutputProtocol {
        let presenter = WeatherPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter)
        presenter.router = router(vc: vc)
        return presenter
        
    }
    
    static func interactor(presenter: WeatherPresenter) -> WeatherInteractorInputProtocol {
        let interactor = WeatherInteractor(presenter: presenter)
        return interactor
    }
    static func router(vc: WeatherViewController) -> WeatherRouterInputProtocol {
        let router = WeatherRouter(view: vc)
        return router
    }
}

struct WeatherCoordinatorDTO {
    
}
