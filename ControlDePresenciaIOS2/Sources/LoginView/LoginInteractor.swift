
import Foundation
import Firebase
//Input del interactor
protocol LoginInteractorInputProtocol {
 
}

final class LoginInteractor: BaseInteractor<LoginInteractorOutputProtocol> {
   
    let provider: LoginProviderInputProtocol = LoginProvider ()
}


//Input del interactor
extension LoginInteractor: LoginInteractorInputProtocol {

    
    
}
