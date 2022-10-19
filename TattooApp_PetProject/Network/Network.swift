//
//  Network.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 16.10.2022.
//

import Foundation

class Network {
    
    func request(complition: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters()
        let url = self.url(params: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = createDataTask(from: request, completion: complition)
        task.resume()
    }
    
    private func prepareParameters() -> [String: String] {
        var parameters = [String: String]()
        parameters["q"] = "минитату"
        parameters["tbm"] = "isch"
        parameters["ijn"] = "0"
        parameters["api_key"] = "cfe2f667a31ea2deb39a7821c929ed25ad0d2cc730641efd8ba10cc3dc00af8a"
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "serpapi.com"
        components.path = "/search.json"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
