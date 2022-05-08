
import Foundation

//Input del interactor
protocol WeatherInteractorInputProtocol {
    
}

final class WeatherInteractor: BaseInteractor<WeatherInteractorOutputProtocol> {
   
    let provider: WeatherProviderInputProtocol = WeatherProvider ()
}


//Input del interactor
extension WeatherInteractor: WeatherInteractorInputProtocol {
    
}
