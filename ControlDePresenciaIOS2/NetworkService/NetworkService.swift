//
//  NetworkService.swift
//  CiceMusic
//
//  Created by Andres Felipe Ocampo Eljaiek on 4/2/22.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func requestGeneric<M: Decodable>(requestPayload: RequestDTO,
                                      entityClass: M.Type,
                                      success: @escaping (M?) -> Void,
                                      failure: @escaping (NetworkError) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    typealias HTTPHeaders = [String: String]
    let defaultHTTPHeaders: HTTPHeaders = {
        return [Utils.Constantes().Authetication: Utils.Constantes().BearerAuthetication]
    }()
    
    func requestGeneric<M>(requestPayload: RequestDTO,
                           entityClass: M.Type,
                           success: @escaping (M?) -> Void,
                           failure: @escaping (NetworkError) -> Void) where M : Decodable {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let baseUrl =  URLEnpoint.getUrlBase(urlContext: requestPayload.urlContext)
        let endpoint = "\(baseUrl)\(requestPayload.endpoint)"
        
        guard let urlUnw = URL(string: endpoint) else {
            failure(NetworkError(status: .unsupportedURL))
            return
        }
        
        var urlRequest = URLRequest(url: urlUnw)
        let headers = defaultHTTPHeaders
        
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard self != nil else { return }
            if let errorUnw = error {
                failure(NetworkError(error: errorUnw))
                return
            }
            guard let httpResponseUnw = response as? HTTPURLResponse, 200..<300 ~= httpResponseUnw.statusCode else {
                failure(NetworkError(status: .badServerResponse))
                return
            }
            guard let dataUnw = data else {
                failure(NetworkError(status: .noContent))
                return
            }
            do {
                let jsonObject = try JSONDecoder().decode(entityClass.self, from: dataUnw)
                DispatchQueue.main.async {
                    success(jsonObject)
                }
            } catch {
                failure(NetworkError(status: .resourceUnavailable))
            }
        }
        .resume()
        session.finishTasksAndInvalidate()
    }
    
    
}

