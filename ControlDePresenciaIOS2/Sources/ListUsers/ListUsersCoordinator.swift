

import Foundation


// MARK: - module builder

final class ListUsersCoordinator {
    static func navigation(dto: ListUsersCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: ListUsersCoordinatorDTO? = nil) -> ListUsersViewController & ListUsersPresenterOutputProtocol {
        print(#function)
        let vc = ListUsersViewController ()
        vc.presenter = presenter(vc: vc)
        return vc
    }
    
    static func presenter(vc: ListUsersViewController) -> ListUsersPresenterInputProtocol & ListUsersInteractorOutputProtocol {
        let presenter = ListUsersPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter)
        presenter.router = router(vc: vc)
        return presenter
        
    }
    
    static func interactor(presenter: ListUsersPresenter) -> ListUsersInteractorInputProtocol {
        let interactor = ListUsersInteractor(presenter: presenter)
        return interactor
    }
    static func router(vc: ListUsersViewController) -> ListUsersRouterInputProtocol {
        let router = ListUsersRouter(view: vc)
        return router
    }
}

struct ListUsersCoordinatorDTO {
    
}
