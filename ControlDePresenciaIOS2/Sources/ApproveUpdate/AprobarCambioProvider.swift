

import Foundation
//Input del provider
protocol AprobarCambioProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class AprobarCambioProvider: AprobarCambioProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct AprobarCambioRequestDTO {

    
}
