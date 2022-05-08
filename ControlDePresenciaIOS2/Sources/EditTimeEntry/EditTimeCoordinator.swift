

import Foundation


// MARK: - module builder

final class EditTimeCoordinator {
    static func navigation(dto: EditTimeCoordinatorDTO? = nil) -> BaseNavigation {
        BaseNavigation(rootViewController: view(dto:dto))
    }
    
    static  func view(dto: EditTimeCoordinatorDTO? = nil) -> EditTimeViewController & EditTimePresenterOutputProtocol {
        print(#function)
        //print(dto)
        let vc = EditTimeViewController ()
        vc.data = dto
        vc.presenter = presenter(vc: vc, dto:dto)
        return vc
    }
    
    static func presenter(vc: EditTimeViewController, dto:EditTimeCoordinatorDTO? = nil) -> EditTimePresenterInputProtocol & EditTimeInteractorOutputProtocol {
        print(#function)
        //print(dto)
        let presenter = EditTimePresenter(vc: vc)
        presenter.interactor = interactor(presenter: presenter, dto:dto)
        presenter.router = router(vc: vc, dto:dto)
        return presenter
        
    }
    
    static func interactor(presenter: EditTimePresenter, dto: EditTimeCoordinatorDTO? = nil) -> EditTimeInteractorInputProtocol {
        print(#function)
        //print(dto)
        let interactor = EditTimeInteractor(presenter: presenter)
        interactor.data = dto
        return interactor
    }
    static func router(vc: EditTimeViewController,dto:EditTimeCoordinatorDTO? = nil) -> EditTimeRouterInputProtocol {
        print(#function)
        //print(dto)
        let router = EditTimeRouter(view: vc)
       
        router.data = dto
        return router
    }
}

struct EditTimeCoordinatorDTO {
    var model:TimeRecord?
}
