
import Foundation

//INput del presenter
protocol EditTimePresenterInputProtocol {
    func loadDataFromInteractor()
    func updateTimeRecord(data:UpdateTimeRecord)
    func generateTimeRecord(data:TimeRecord, newEntry:String,newExit:String)
    
}


//Output del interactor
protocol EditTimeInteractorOutputProtocol {
    func dataTransformedFromInteractor(data:[UpdateTimeRecord])
}



final class EditTimePresenter: BasePresenter <EditTimePresenterOutputProtocol , EditTimeInteractorInputProtocol, EditTimeRouterInputProtocol>  {
    var dataSourceModel:[UpdateTimeRecord] = []
}

//Input del interactor
extension EditTimePresenter: EditTimePresenterInputProtocol {
    func loadDataFromInteractor() {
        //<#code#>
    }
    
    func updateTimeRecord(data: UpdateTimeRecord) {
        //
    }
    func generateTimeRecord(data: TimeRecord, newEntry: String, newExit: String) {
        let updateRequest =   self.interactor?
            .createUpdateRequest(data: data,
                                 newEntry: newEntry,
                                 newExit: newExit)
        if (updateRequest == true) {
            debugPrint("Ok generated time record")
        }
    }
    
    
    
}

//Output del interactor
extension EditTimePresenter: EditTimeInteractorOutputProtocol {
    
    
    func dataTransformedFromInteractor(data: [UpdateTimeRecord]) {
        //
    }
}


