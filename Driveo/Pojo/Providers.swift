//
//  Providers.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//


// To parse the JSON, add this file to your project and do:
//
//   let providers = try? JSONDecoder().decode(Providers.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProviders { response in
//     if let providers = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

struct Providers: Codable {
    let providers: [Provider]?
}

public struct Provider: Codable {
    let id: Int?
    let name: String?
    let image: Image?
    let rating: String?
}

struct Image: Codable {
    let url: String?
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseProviders(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Providers>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
