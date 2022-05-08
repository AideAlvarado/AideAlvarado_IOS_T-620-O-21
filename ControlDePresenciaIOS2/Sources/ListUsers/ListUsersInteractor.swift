
import Foundation
import Firebase
//Input del interactor
protocol ListUsersInteractorInputProtocol {
    func transformDataFromInteractor()
    func getProfilePictures()
}

final class ListUsersInteractor: BaseInteractor<ListUsersInteractorOutputProtocol> {
   
    let provider: ListUsersProviderInputProtocol = ListUsersProvider ()
    var user: Firebase.User? = Auth.auth().currentUser
    var ref: DatabaseReference! = Database.database().reference()
    var usersTable = [UserRecord]()
}


//Input del interactor
extension ListUsersInteractor: ListUsersInteractorInputProtocol {
    func getProfilePictures() {
        debugPrint("ListUserInteractor",#function)
        ref.child(K.picturesTable)
            .observe(DataEventType.value){ (users) in
                if let user = users.value as? [String:Any]
                {
                    debugPrint("---------------------Hay usuarios")
                    for object in user.values   {
                        debugPrint("Usuario")
                        debugPrint(object)
                    }
                }
                
            }
    }
    
    func transformDataFromInteractor() {
        debugPrint(#function)
        ref.child(K.userTable)
            .queryOrdered(byChild: "email")
            .observe(DataEventType.value){ (users) in
                if let user = users.value as? [String:Any] {
                    self.usersTable = []
                    for object in user.values{
                        if let objectItem = object as? [String:Any]{
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
                                                             avatar: mAvatar ?? "")
                            )
                        }
                    }
                    self.presenter?.dataTransformedFromInteractor(data: self.usersTable)
                }
                
            }
    }
    
}
