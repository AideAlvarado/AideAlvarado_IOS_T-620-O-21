

import Foundation
//Input del provider
protocol WeatherProviderInputProtocol {
    // aqui va la llamada al fetch data
   func fetchData(completioHadler:@escaping (Result<Welcome,NetworkError>) -> Void )
    /**
     le
     */
}

final class WeatherProvider: WeatherProviderInputProtocol{
    func fetchData(completioHadler: @escaping (Result<Welcome, NetworkError>) -> Void) {
        
        self.networkService.requestGeneric(requestPayload: WeatherRequestDTO
            .requestData(numeroItems: "12"),
                                           entityClass: Welcome.self) { [weak self ] (result) in
            guard self != nil else {return }
        
            guard let resultUnw = result else {return}
            completioHadler(.success(resultUnw))
        } failure: { (error) in
            debugPrint(error)
            completioHadler(.failure(error))
        }
    }
    

    
    let networkService: NetworkServiceProtocol = NetworkService()
}


struct WeatherRequestDTO {
    static func requestData(numeroItems: String) -> RequestDTO {
        let argument: [CVarArg] = [numeroItems]
        let urlComplete = String(format: URLEnpoint.weather,
                                 arguments:argument)
        let requests = RequestDTO(params: nil,
                                  method: .get,
                                  endpoint: urlComplete,
                                  urlContext: .backend)
        return requests
    }
    
}
