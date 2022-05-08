

import Foundation
//Input del provider
protocol ListUsersProviderInputProtocol {
    // aqui va la llamada al fetch data
    
}

final class ListUsersProvider: ListUsersProviderInputProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct ListUsersRequestDTO {

    
}
