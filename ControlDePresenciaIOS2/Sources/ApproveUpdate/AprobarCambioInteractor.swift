
import Foundation
import Firebase
//Input del interactor
protocol AprobarCambioInteractorInputProtocol {
    func updateUser(data:UpdateTimeRecord)
}

final class AprobarCambioInteractor: BaseInteractor<AprobarCambioInteractorOutputProtocol> {
    
    let provider: AprobarCambioProviderInputProtocol = AprobarCambioProvider ()
    var data: AprobarCambioCoordinatorDTO?
    var user: Firebase.User? = Auth.auth().currentUser
    var ref:DatabaseReference! = Database.database().reference()
    var tasksTable = [UpdateTimeRecord]()
    var db = Firestore.firestore()
    var defaults = UserDefaults.standard
    func newTimeRecord(data:UpdateTimeRecord)->TimeRecord {
        let minutosIniciales = TimeUtils.timeToMinutes(data: data.requestEntry)
        let minutosFinales = TimeUtils.timeToMinutes(data: data.requestExit)
        return TimeRecord(id: data.id,
                          userId: data.userId,
                          day: data.day,
                          clockIn: data.requestEntry,
                          clockOut: data.requestExit,
                          minutes: minutosFinales - minutosIniciales)
    }
}


//Input del interactor
extension AprobarCambioInteractor: AprobarCambioInteractorInputProtocol {
    func updateUser(data: UpdateTimeRecord) {
        //Update record on firestore
        let managerName = defaults.object(forKey: K.managerName) as? String ?? "--"
        let dbPath = "tareas/TENANT/\(managerName)"
        db.collection(dbPath).document(data.requestId).setData(data.dictionary){(error) in
            if let e = error {
                debugPrint("Firestore not updated")
                debugPrint(e.localizedDescription)
            } else {
                // actualizamos el registro de RealtimeDB
                let tr = self.newTimeRecord(data: data)
                self.ref.child(K.timeRecordsTable).child(tr.id)
                    .setValue(tr.dictionary){
                        error, dbReference in
                        if let e = error {
                            debugPrint("Error " + e.localizedDescription)
                        }
                        else {
                            debugPrint("Grabado con éxito")
                        }
                    }
            }
        }
    }
}
