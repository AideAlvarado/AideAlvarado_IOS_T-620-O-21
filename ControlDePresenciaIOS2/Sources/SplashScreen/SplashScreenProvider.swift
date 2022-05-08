

import Foundation
//Input del provider
protocol SplashScreenProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class SplashScreenProvider: SplashScreenProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct SplashScreenRequestDTO {

    
}
