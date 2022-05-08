
import Foundation

//INput del presenter
protocol WeatherPresenterInputProtocol {
    
}


//Output del interactor
protocol WeatherInteractorOutputProtocol {
    
}



final class WeatherPresenter: BasePresenter <WeatherPresenterOutputProtocol , WeatherInteractorInputProtocol, WeatherRouterInputProtocol>  {
    
}

//Input del interactor
extension WeatherPresenter: WeatherPresenterInputProtocol {
    
}

//Output del interactor
extension WeatherPresenter: WeatherInteractorOutputProtocol {
    
}


