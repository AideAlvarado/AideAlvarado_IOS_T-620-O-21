
import Foundation
import Firebase
import UIKit
//INput del presenter
protocol ClockInPresenterInputProtocol {
    func loadLocalData() -> LocalConfig?
    func saveLocalData(config:LocalConfig)
    func loadDataFromInteractor()
    func numberOfRows() -> Int?
    func didSelectRow(data:TimeRecord)
    func informationForCell(indexPath:Int)->TimeRecord?
    func logout()
    func saveCurrentTimeRecord(data:TimeRecord)
    func showEditDialog(data:TimeRecord)
    func showUsersList()
    func showTasksList()
    func setUpdateClock()
    func fetchData(city:String)
}


//Output del interactor
protocol ClockInInteractorOutputProtocol {
    func dataTransformedFromInteractor(data:[TimeRecord]?)
    func dataFromWeather(data:Welcome?)
}



final class ClockInPresenter: BasePresenter <ClockInPresenterOutputProtocol , ClockInInteractorInputProtocol, ClockInRouterInputProtocol>  {
    //MARK: - Variables globales
    var dataSourceViewModel:[TimeRecord] = []
    var weatherDataModel:[Welcome] = []
    var mClockedIn :Bool = false
    var mClockInTime: String = ""
    var mClockOutTime: String = ""
    
}

//Input del interactor
extension ClockInPresenter: ClockInPresenterInputProtocol {
    func fetchData(city:String) {
        self.interactor?.transformWeatherDataFromInteractor(city:city)
    }
    
    func setUpdateClock() {
        debugPrint(#function)
        Timer.scheduledTimer(withTimeInterval: 1,
                             repeats: true) { (timer) in
            //debugPrint(Date.now)
            //debugPrint(TimeUtils.horaActual())
            self.viewController?.updateTime()
        }
    }
    
    func showTasksList() {
        self.router?.showTasksList()
    }
    
    func showUsersList() {
        self.router?.showUsersList()
    }
    
    func showEditDialog(data: TimeRecord) {
        debugPrint(#function)
        debugPrint(data)
        self.router?.showEditDataDialog(data: data)
    }
    
    func saveCurrentTimeRecord(data: TimeRecord) {
        self.interactor?.saveTimeRecordEntry(data: data)
    }
    
    func logout() {

    }
    
    func informationForCell(indexPath: Int) -> TimeRecord? {
        return self.dataSourceViewModel[indexPath]
    }
    
    func loadDataFromInteractor() {
        //
        self.interactor?.transformDataFromInteractor()
    }
    
    func numberOfRows() -> Int? {
        return self.dataSourceViewModel.count
    }
    
    func didSelectRow(data: TimeRecord) {
        //
        self.router?.didSelectRowRouter(data: data)
    }
    
    func saveLocalData(config:LocalConfig) {
        self.interactor?.saveLocalData(config:config)
    }
    
    func loadLocalData() -> LocalConfig? {
        return self.interactor?.loadConfig() ?? nil
    }
    
    
}

//Output del interactor
extension ClockInPresenter: ClockInInteractorOutputProtocol {
    func dataFromWeather(data: Welcome?) {
        guard let dataUnw = data else {return}
        debugPrint(dataUnw)
        self.viewController?.updateWeather(data: dataUnw)
    }
    
    func dataTransformedFromInteractor(data: [TimeRecord]?) {
        debugPrint(#function)
        self.dataSourceViewModel.removeAll()
        guard let dataSourceUnw = data else {return}
        self.dataSourceViewModel = dataSourceUnw
        self.viewController?.reloadInformationInView()  
    }
    
    
}


