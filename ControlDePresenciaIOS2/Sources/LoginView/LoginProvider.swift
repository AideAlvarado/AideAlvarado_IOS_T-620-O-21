

import Foundation
//Input del provider
protocol LoginProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class LoginProvider: LoginProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct LoginRequestDTO {
    
}
