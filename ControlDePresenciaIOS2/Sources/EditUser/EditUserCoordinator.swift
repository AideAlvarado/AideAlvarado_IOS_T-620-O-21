

import Foundation


// MARK: - module builder

final class EditUserCoordinator {
    static func navigation(dto: EditUserCoordinatorDTO? = nil) -> BaseNavigation {
        debugPrint(#function)
        return BaseNavigation(rootViewController: view(dto:dto))
    }
    
    static  func view(dto: EditUserCoordinatorDTO? = nil) -> EditUserViewController & EditUserPresenterOutputProtocol {
        print(#function)
        let vc = EditUserViewController ()
        vc.data = dto
        vc.presenter = presenter(vc: vc, dto:dto)
        return vc
    }
    
    static func presenter(vc: EditUserViewController, dto:EditUserCoordinatorDTO? = nil) -> EditUserPresenterInputProtocol & EditUserInteractorOutputProtocol {
        debugPrint(#function)
        let presenter = EditUserPresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter, dto:dto)
        presenter.router = router(vc: vc, dto: dto)
        return presenter
        
    }
    
    static func interactor(presenter: EditUserPresenter, dto: EditUserCoordinatorDTO? = nil) -> EditUserInteractorInputProtocol {
        debugPrint(#function)
        let interactor = EditUserInteractor(presenter: presenter)
        interactor.data = dto
        return interactor
    }
    static func router(vc: EditUserViewController, dto: EditUserCoordinatorDTO? = nil) -> EditUserRouterInputProtocol {
        debugPrint(#function)
        let router = EditUserRouter(view: vc)
        router.data = dto
        return router
    }
}

struct EditUserCoordinatorDTO {
    var model:UserRecord?
}
