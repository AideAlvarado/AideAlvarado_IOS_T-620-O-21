

import Foundation
//Input del provider
protocol EditTimeProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class EditTimeProvider: EditTimeProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct EditTimeRequestDTO {

}
