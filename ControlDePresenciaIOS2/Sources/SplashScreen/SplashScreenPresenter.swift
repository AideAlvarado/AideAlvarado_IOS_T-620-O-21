
import Foundation

//INput del presenter
protocol SplashScreenPresenterInputProtocol {
    func showLogin()
    func showMainMenu()
    func showRegister()
    func getApiKeys()
}


//Output del interactor
protocol SplashScreenInteractorOutputProtocol {
    
}



final class SplashScreenPresenter: BasePresenter <SplashScreenPresenterOutputProtocol , SplashScreenInteractorInputProtocol, SplashScreenRouterInputProtocol>  {
    
}

//Input del interactor
extension SplashScreenPresenter: SplashScreenPresenterInputProtocol {
    func getApiKeys() {
        self.interactor?.getApiKeys()
    }
    
    func showMainMenu() {
        self.router?.showMainMenu()
    }
    
    func showLogin() {
        self.router?.showLogin()
    }
    
    func showRegister() {
        self.router?.showRegister()
    }
}

//Output del interactor
extension SplashScreenPresenter: SplashScreenInteractorOutputProtocol {
    
}


