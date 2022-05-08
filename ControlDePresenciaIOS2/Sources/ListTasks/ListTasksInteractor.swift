
import Foundation
import Firebase
//Input del interactor
protocol ListTasksInteractorInputProtocol {
    func transformDataFromInteractor()
}

final class ListTasksInteractor: BaseInteractor<ListTasksInteractorOutputProtocol> {
    var defaults = UserDefaults.standard
    let provider: ListTasksProviderInputProtocol = ListTasksProvider ()
    var user: Firebase.User? = Auth.auth().currentUser
    var ref: DatabaseReference! = Database.database().reference()
    var taskTable = [UpdateTimeRecord]()
    var data: ListTasksCoordinatorDTO?
    var db = Firestore.firestore()
    
}


//Input del interactor
extension ListTasksInteractor: ListTasksInteractorInputProtocol {
    func transformDataFromInteractor() {
        //
        let managerName = defaults.object(forKey: K.managerName) as? String ?? "--"
        let dbPath = "tareas/TENANT/\(managerName)"
        db.collection(dbPath).whereField("status", isEqualTo: K.STATUS_PENDING).addSnapshotListener { (querySnapshot,error )in
        
            if let e = error {
                debugPrint("There was an issue retrieving data from Firestore" + e.localizedDescription)
            } else {
                self.taskTable = []
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        print(data)
                        let clockIn = data["clockIn"] as? String ?? ""
                        let clockOut = data["clockOut"] as? String ?? ""
                        let confirmedTimeUpdate = data["confirmedTimeUpdate"] as? String ?? ""
                        let day = data["day"] as? String ?? ""
                        let displayName = data["displayName"] as? String ?? ""
                        let id = data["id"] as? String ?? ""
                        let managerId = data["managerId"] as? String ?? ""
                        let minutes = data["minutes"] as? Int ?? 0
                        let requestEntry = data["requestEntry"] as? String ?? ""
                        let requestExit = data["requestExit"] as? String ?? ""
                        let requestId = data["requestId"] as? String ?? ""
                        let requestedTimeUpdate = data["requestedTimeUpdate"] as? String ?? ""
                        let status = data["status"] as? Int ?? 0
                        let userId = data["userId"] as? String ?? ""

                        let tr = UpdateTimeRecord(id: id,
                                                               userId: userId,
                                                               displayName: displayName,
                                                               day: day,
                                                               clockIn: clockIn,
                                                               clockOut: clockOut,
                                                               requestEntry: requestEntry,
                                                               requestExit: requestExit,
                                                               minutes: minutes,
                                                               managerId: managerId,
                                                               requestedTimeUpdate: requestedTimeUpdate,
                                                               confirmedTimeUpdate: confirmedTimeUpdate,
                                                               requestId: requestId,
                                                               status: status)
                        debugPrint(tr)
                        self.taskTable.append( tr)
                    }
                }
                self.presenter?.dataTransformedFromInteractor(data:self.taskTable)
            }
            
        }
            
    }
    
    
}
