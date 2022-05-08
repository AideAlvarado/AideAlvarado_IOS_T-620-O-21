
import Foundation
import UIKit
import Firebase
//INput del presenter
protocol LoginPresenterInputProtocol {
    func showMainScreen()
}


//Output del interactor
protocol LoginInteractorOutputProtocol {
    
}



final class LoginPresenter: BasePresenter <LoginPresenterOutputProtocol , LoginInteractorInputProtocol, LoginRouterInputProtocol>  {
    
}

//Input del interactor
extension LoginPresenter: LoginPresenterInputProtocol {
    func showMainScreen() {
        debugPrint(#function)
        self.router?.showMainScreen()
    }
    

    

}

//Output del interactor
extension LoginPresenter: LoginInteractorOutputProtocol {
    
}


