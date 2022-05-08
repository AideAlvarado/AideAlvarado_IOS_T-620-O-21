
import Foundation

//INput del presenter
protocol EditUserPresenterInputProtocol {
    func loadDataFromInteractor()
func numberOfComponents() -> Int
    func titleForRow(indexPath:Int)->String
    func selectedManager(_ manager:String)->Int
    func updateUser(initial:UserRecord
                , displayName:String,isManager:Bool,isEnabled:Bool,manager:String) ->Bool
}


//Output del interactor
protocol EditUserInteractorOutputProtocol {
    func dataTransformedFromInteractor(data:[UserRecord]?)
    
}



final class EditUserPresenter: BasePresenter <EditUserPresenterOutputProtocol , EditUserInteractorInputProtocol, EditUserRouterInputProtocol>  {
    var dataSourceViewModel:[UserRecord] = []
    var emailTable:[String] = ["Manager"]
}

//Input del interactor
extension EditUserPresenter: EditUserPresenterInputProtocol {
    func updateUser(initial: UserRecord, displayName: String, isManager: Bool, isEnabled: Bool, manager: String) -> Bool {
        if (initial.displayName != displayName || initial.esGerente != isManager || initial.estaActivado != isEnabled || initial.manager != manager){
            self.interactor?.updateUser(data: UserRecord(displayName: displayName,email: initial.email, tenant: initial.tenant, manager: manager, estaActivado: isEnabled, esGerente: isManager, uuid: initial.uuid, avatar: initial.avatar))
            return  true
        }
        else {
            return false
        }
    }
    
    
    func selectedManager(_ manager: String) -> Int {
        debugPrint(manager)
        var indice:Int = 0
        //var notFound:Bool = true
        for name in emailTable {
            debugPrint("manager..%@",name)
            if name == manager {
                return indice
                //notFound = false
            }
            indice += 1
        }
        return 0
    }
    
    func titleForRow(indexPath: Int) -> String {
        return emailTable[indexPath]
    }
    
func numberOfComponents() ->Int {
        return self.dataSourceViewModel.count + 1
    }
    
    func loadDataFromInteractor() {
        self.interactor?.transformDataFromInteractor()
    }
    
    
}

//Output del interactor
extension EditUserPresenter: EditUserInteractorOutputProtocol {
    func dataTransformedFromInteractor(data:[UserRecord]?) {
        debugPrint(#function)
        self.emailTable.removeAll()
        guard let dataSourceUnw = data else {return}
        self.emailTable.append("Manager")
        for data in dataSourceUnw {
            debugPrint(data)
            self.emailTable.append(data.email)
        }
        self.dataSourceViewModel = dataSourceUnw
        self.viewController?.reloadInformationInView()
    }
    
}


