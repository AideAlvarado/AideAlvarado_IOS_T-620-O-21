
import Foundation
import Firebase
//Input del interactor
protocol RegisterInteractorInputProtocol {
    func saveUserData(uid:String,username: String, friendlyName: String, password: String, profilePicture: String)}

final class RegisterInteractor: BaseInteractor<RegisterInteractorOutputProtocol> {
   
    let provider: RegisterProviderInputProtocol = RegisterProvider ()
    var user = Auth.auth().currentUser
    var ref:DatabaseReference = Database.database().reference()
    
}


//Input del interactor
extension RegisterInteractor: RegisterInteractorInputProtocol {
    func saveUserData(uid:String,username: String, friendlyName: String, password: String, profilePicture: String) {
        //
        let newEntry = UserRecord(displayName: friendlyName,
                        email: username,
                            tenant: K.tenantID,
                            manager: "Manager",
                            estaActivado: false,
                            esGerente: false,
                            uuid: uid,
                            avatar: profilePicture)
        let key = username.replacingOccurrences(of: ".", with: "_")
        ref.child(K.userTable).child(key).setValue(newEntry.dictionary)
        ref.child(K.picturesTable).child(newEntry.uuid).setValue(["userName":newEntry.uuid,
                                                                  "profilePicture":profilePicture])
    }
    
    
}
