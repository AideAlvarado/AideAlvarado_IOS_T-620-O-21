

import Foundation
//Input del provider
protocol EditUserProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class EditUserProvider: EditUserProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct EditUserRequestDTO {

    
}
