

import Foundation
//Input del provider
protocol RegisterProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class RegisterProvider: RegisterProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct RegisterRequestDTO {

    
}
