

import Foundation
//Input del provider
protocol ClockInProviderInputProtocol {
    // aqui va la llamada al fetch data
    func fetchData(city:String,completioHadler:@escaping (Result<Welcome,NetworkError>) -> Void )}

final class ClockInProvider: ClockInProviderInputProtocol{
    var defaults = UserDefaults.standard
    
    let networkService: NetworkServiceProtocol = NetworkService()
    func fetchData(city:String,completioHadler: @escaping (Result<Welcome, NetworkError>) -> Void) {
        let apiKey = defaults.object(forKey: K.apiKey) as? String ?? "-"
        self.networkService.requestGeneric(requestPayload: ClockInRequestDTO
            .requestData(ciudad: city,apiKey : apiKey),
                                           entityClass: Welcome.self) { [weak self ] (result) in
            guard self != nil else {return }
        
            guard let resultUnw = result else {return}
            
            completioHadler(.success(resultUnw))
        } failure: { (error) in
            debugPrint(error)
            completioHadler(.failure(error))
        }
    }
}


struct ClockInRequestDTO {
    static func requestData(ciudad: String,apiKey:String) -> RequestDTO {
        let argument: [CVarArg] = [ciudad,apiKey]
        let urlComplete = String(format: URLEnpoint.weather,
                                 arguments:argument)
        let requests = RequestDTO(params: nil,
                                  method: .get,
                                  endpoint: urlComplete,
                                  urlContext: .backend)
        return requests
    }
}
