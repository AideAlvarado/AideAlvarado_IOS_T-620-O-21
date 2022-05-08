
import Foundation

//INput del presenter
protocol AprobarCambioPresenterInputProtocol {
    func loadDataFromInteractor()
    func updateTask(data:UpdateTimeRecord)
}


//Output del interactor
protocol AprobarCambioInteractorOutputProtocol {
    
}



final class AprobarCambioPresenter: BasePresenter <AprobarCambioPresenterOutputProtocol , AprobarCambioInteractorInputProtocol, AprobarCambioRouterInputProtocol>  {
    var dataSourceViewModel:[UpdateTimeRecord] = []
    
}

//Input del interactor
extension AprobarCambioPresenter: AprobarCambioPresenterInputProtocol {
    func loadDataFromInteractor(){}
    func updateTask(data:UpdateTimeRecord){
        self.interactor?.updateUser(data: data)
    }
    
}

//Output del interactor
extension AprobarCambioPresenter: AprobarCambioInteractorOutputProtocol {
    
}


