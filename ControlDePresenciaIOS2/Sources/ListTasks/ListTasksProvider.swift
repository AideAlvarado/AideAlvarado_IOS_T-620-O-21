

import Foundation
//Input del provider
protocol ListTasksProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class ListTasksProvider: ListTasksProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct ListTasksRequestDTO {

    
}
