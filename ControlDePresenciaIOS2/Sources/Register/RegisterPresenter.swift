
import Foundation
import UIKit

//INput del presenter
protocol RegisterPresenterInputProtocol {
    func showMainScreenFromRegister(displayName:String, imageView:UIImageView)
    func saveUserData(uid:String,username:String,friendlyName:String, password:String,profilePicture:String )
}


//Output del interactor
protocol RegisterInteractorOutputProtocol {
    
}



final class RegisterPresenter: BasePresenter <RegisterPresenterOutputProtocol , RegisterInteractorInputProtocol, RegisterRouterInputProtocol>  {
    
}

//Input del interactor
extension RegisterPresenter: RegisterPresenterInputProtocol {
    func saveUserData(uid:String,username: String, friendlyName: String, password: String, profilePicture: String) {
        self.interactor?.saveUserData(uid:uid,
                                      username: username,
                                      friendlyName: friendlyName,
                                      password: password,
                                      profilePicture: profilePicture)
    }
    
   
    
    func showMainScreenFromRegister(displayName:String,imageView:UIImageView) {
        debugPrint(#function)
        self.router?.showMainScreenFromRegister()
    }
    
    
}

//Output del interactor
extension RegisterPresenter: RegisterInteractorOutputProtocol {
    
}


