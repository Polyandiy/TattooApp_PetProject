//
//  NetworkDataFether.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 16.10.2022.
//

import Foundation

class NetworkDataFether {
    
    var network = Network()
    
    func fetchImages(complition: @escaping (APIResponse?) -> ()) {
        network.request { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                complition(nil)
            }
            let decode = self.decodeJSON(type: APIResponse.self, from: data)
            complition(decode)
        }
    }
    
    func decodeJSON<T: Codable>(type: T.Type, from: Data?) -> T? {
        guard let data = from else { return nil }
        do {
            let items = try JSONDecoder().decode(type.self, from: data)
            return items
        } catch let JSONError {
            print("Failed to decode JSON", JSONError)
            return nil
        }
    }
}
