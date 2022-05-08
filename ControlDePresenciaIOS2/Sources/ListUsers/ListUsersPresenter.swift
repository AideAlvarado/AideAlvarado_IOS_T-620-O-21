
import Foundation

//INput del presenter
protocol ListUsersPresenterInputProtocol {
    func loadDataFromInteractor()
    func numberOfRows() ->Int?
    func didSelectRow(data:UserRecord)
    func informationForCell(indexPath:Int)->UserRecord
    func showEditUser(data:UserRecord)
    func showSplashScreen()
    func getProfilePictures()
    
}


//Output del interactor
protocol ListUsersInteractorOutputProtocol {
    func dataTransformedFromInteractor(data:[UserRecord]?)
}



final class ListUsersPresenter: BasePresenter <ListUsersPresenterOutputProtocol , ListUsersInteractorInputProtocol, ListUsersRouterInputProtocol>  {
    var dataSourceViewModel:[UserRecord] = []
    
}

//Input del interactor
extension ListUsersPresenter: ListUsersPresenterInputProtocol {
    func getProfilePictures() {
        debugPrint("ListUserPresenter",#function)
        self.interactor?.getProfilePictures()
    }
    

    
    func showSplashScreen() {
        self.router?.goToSplashScreen()
    }
    
    func loadDataFromInteractor() {
        debugPrint(#function)
        self.interactor?.transformDataFromInteractor()
    }
    
    func numberOfRows() -> Int? {
        return self.dataSourceViewModel.count
    }
    
    func didSelectRow(data: UserRecord) {
        self.router?.didSelectRowRouter(data: data)
    }
    
    func informationForCell(indexPath: Int) -> UserRecord {
        return self.dataSourceViewModel[indexPath]
    }
    
    func showEditUser(data: UserRecord) {
        self.router?.showEditUserDialog(data: data)
    }
}

//Output del interactor
extension ListUsersPresenter: ListUsersInteractorOutputProtocol {
    
    func dataTransformedFromInteractor(data:[UserRecord]?) {
        debugPrint(#function)
        self.dataSourceViewModel.removeAll()
        guard let dataSourceUnw = data else {return}
        self.dataSourceViewModel = dataSourceUnw
        self.viewController?.reloadInformationInView()
    }
}


