
import Foundation
import Firebase

//Input del interactor
protocol EditTimeInteractorInputProtocol {
    func transformDataFromInteractor()
    func createUpdateRequest(data:TimeRecord,newEntry:String    , newExit:String) -> Bool
}

final class EditTimeInteractor: BaseInteractor<EditTimeInteractorOutputProtocol> {
    var defaults = UserDefaults.standard
    var data: EditTimeCoordinatorDTO?
    let provider: EditTimeProviderInputProtocol = EditTimeProvider ()
    var user:Firebase.User? = Auth.auth().currentUser
    var ref:DatabaseReference! = Database.database().reference()
    let db = Firestore.firestore()
    var updatesTable = [UpdateTimeRecord]()
}


//Input del interactor
extension EditTimeInteractor: EditTimeInteractorInputProtocol {
    func createUpdateRequest(data: TimeRecord, newEntry: String, newExit: String) -> Bool{
        var nuevaEntrada:String?
        var nuevaSalida:String?
        var entryMinutes = TimeUtils.timeToMinutes(data: newEntry)
        var exitMinutes = TimeUtils.timeToMinutes(data:newExit)
        if entryMinutes < 0 {
            entryMinutes = TimeUtils.timeToMinutes(data: data.clockIn)
            nuevaEntrada = data.clockIn
        } else {
            nuevaEntrada = newEntry
        }
        if exitMinutes < 0 {
            exitMinutes = TimeUtils.timeToMinutes(data: data.clockOut)
            nuevaSalida = data.clockOut
        } else {
            nuevaSalida = newExit
        }
        if exitMinutes <= entryMinutes
        {return false}
        else {
            //var displayName = defaults.object(forKey: K.displayName) as? String ?? "--"
            let managerName = defaults.object(forKey: K.managerName) as? String ?? "--"
            //var statusRequest = K.STATUS_PENDING
            let requestId = UUID().uuidString
            let updateRecord = UpdateTimeRecord(id: data.id,
                                                userId: data.userId,
                                                displayName: defaults.object(forKey: K.displayName) as? String ?? "--",
                                                day: data.day,
                                                clockIn: data.clockIn,
                                                clockOut: data.clockOut,
                                                requestEntry: nuevaEntrada ?? data.clockIn,
                                                requestExit: nuevaSalida ?? data.clockOut,
                                                minutes: exitMinutes - entryMinutes,
                                                managerId: defaults.object(forKey: K.managerName) as? String ?? "-.",
                                                requestedTimeUpdate: TimeUtils.fechaHoraActual() ,
                                                confirmedTimeUpdate: "",
                                                requestId: requestId,
                                                status: K.STATUS_PENDING)
            let dbPath = "tareas/TENANT/\(managerName)"
            debugPrint(dbPath)
            debugPrint(requestId)
            db.collection(dbPath).document(requestId).setData( updateRecord.dictionary) { (error) in
                if let e = error {
                    debugPrint(e.localizedDescription)
                }
            }
            return true
        }
        
    }
    
    func transformDataFromInteractor() {
        //
    }
    
    
}
