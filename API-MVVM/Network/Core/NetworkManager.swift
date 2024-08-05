//
//  NetworkManager.swift
//  API-MVVM
//
//  Created by Murat Tunca on 5.08.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Decodable>(type: T.Type, url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
                print("failure: ", error)
            }
        }
        .response { response in
            if let statusCode = response.response?.statusCode {
                print("HTTP Status Code: \(statusCode)")
            }
        }
    }
}
