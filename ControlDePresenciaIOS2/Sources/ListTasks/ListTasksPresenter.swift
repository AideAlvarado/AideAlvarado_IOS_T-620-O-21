
import Foundation

//INput del presenter
protocol ListTasksPresenterInputProtocol {
    func loadDataFromInteractor()
func numberOfRows() -> Int?
    func didSelectRow(data:UpdateTimeRecord)
    func informationForCell(indexPath:Int)->UpdateTimeRecord?
    func showApproveTimeUpdate(data:[UpdateTimeRecord])
    
}


//Output del interactor
protocol ListTasksInteractorOutputProtocol {
    func dataTransformedFromInteractor(data:[UpdateTimeRecord]?)
}



final class ListTasksPresenter: BasePresenter <ListTasksPresenterOutputProtocol , ListTasksInteractorInputProtocol, ListTasksRouterInputProtocol>  {
    var dataSourceViewModel:[UpdateTimeRecord] = []
}

//Input del interactor
extension ListTasksPresenter: ListTasksPresenterInputProtocol {
    func loadDataFromInteractor() {
        //
        self.interactor?.transformDataFromInteractor()
    }
    
    func numberOfRows() -> Int? {
        //
        return dataSourceViewModel.count
    }
    
    func didSelectRow(data: UpdateTimeRecord) {
        //
        self.router?.didSelectRow(data: data)
    }
    
    func informationForCell(indexPath: Int) -> UpdateTimeRecord? {
        return dataSourceViewModel[indexPath]
    }
    
    func showApproveTimeUpdate(data: [UpdateTimeRecord]) {
        //
    }
}

//Output del interactor
extension ListTasksPresenter: ListTasksInteractorOutputProtocol {
    func dataTransformedFromInteractor(data: [UpdateTimeRecord]?) {
        //
        self.dataSourceViewModel.removeAll()
        guard let dataSourceUnw = data else {return }
        self.dataSourceViewModel = dataSourceUnw
        self.viewController?.reloadInformationInView()  
    }
    
    
}


