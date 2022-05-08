

import Foundation


// MARK: - module builder

final class ListTasksCoordinator {
    static func navigation(dto: ListTasksCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view())
    }
    
    static  func view(dto: ListTasksCoordinatorDTO? = nil) -> ListTasksViewController & ListTasksPresenterOutputProtocol {
        print(#function)
        let vc = ListTasksViewController ()
        vc.data = dto
        vc.presenter = presenter(vc: vc, dto:dto)
        return vc
    }
    
    static func presenter(vc: ListTasksViewController, dto:ListTasksCoordinatorDTO? = nil) -> ListTasksPresenterInputProtocol & ListTasksInteractorOutputProtocol {
        let presenter = ListTasksPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter, dto:dto)
        
        presenter.router = router(vc: vc, dto: dto)
        return presenter
        
    }
    
    static func interactor(presenter: ListTasksPresenter,
                           dto:ListTasksCoordinatorDTO? = nil) -> ListTasksInteractorInputProtocol {
        let interactor = ListTasksInteractor(presenter: presenter)
        interactor.data = dto
        return interactor
    }
    static func router(vc: ListTasksViewController, dto: ListTasksCoordinatorDTO? = nil) -> ListTasksRouterInputProtocol {
        let router = ListTasksRouter(view: vc)
        router.data = dto
        return router
    }
}

struct ListTasksCoordinatorDTO {
    var model:UpdateTimeRecord?
}
