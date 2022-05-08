
import Foundation
import Firebase
//Input del interactor
protocol EditUserInteractorInputProtocol {
    func transformDataFromInteractor()
    func updateUser(data:UserRecord)
}

final class EditUserInteractor: BaseInteractor<EditUserInteractorOutputProtocol> {
    var  data: EditUserCoordinatorDTO?
    let provider: EditUserProviderInputProtocol = EditUserProvider ()
    var user: Firebase.User? = Auth.auth().currentUser
    var ref: DatabaseReference! = Database.database().reference()
    var usersTable = [UserRecord]()
}


//Input del interactor
extension EditUserInteractor: EditUserInteractorInputProtocol {
    func updateUser(data: UserRecord) {
        debugPrint(data.dictionary)
        debugPrint(data)
        let key = data.email.replacingOccurrences(of: ".", with: "_")
        ref.child(K.userTable).child(key).setValue(data.dictionary)
        
    }
    
    func transformDataFromInteractor() {
        ref.child(K.userTable)
            .queryOrdered(byChild: "esGerente")
            .queryEqual(toValue: true)
            .observe(DataEventType.value) {(users) in
                if let user = users.value as? [String:Any] {
                    self.usersTable = []
                    
                    for object in user.values {
                        if let objectItem = object as? [String:Any] {
                            let mDisplayName = objectItem["displayName"] as? String
                            let mEMail = objectItem["email"] as? String
                            let mEsGerente = objectItem["esGerente"] as? Bool
                            let mManager = objectItem["manager"] as? String
                            let mTenant = objectItem["tenant"] as? String
                            let mUUID = objectItem["uuid"] as? String
                            let mActivo = objectItem["estaActivado"] as? Bool
                            let mAvatar = objectItem["avatar"] as? String
                            self.usersTable.append(UserRecord(displayName: mDisplayName ?? "",
                                                        email: mEMail ?? "",
                                                        tenant: mTenant ?? "",
                                                        manager: mManager ?? "",
                                                        estaActivado: mActivo ?? false,
                                                        esGerente: mEsGerente ?? false,
                                                        uuid: mUUID ?? "",
                                                        avatar:mAvatar ?? "")
                            )
                            
                        }
                    }
                    self.presenter?.dataTransformedFromInteractor(data: self.usersTable)

                }
                
            }
    }
    
}
