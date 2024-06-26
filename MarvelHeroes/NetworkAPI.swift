//
//  NetworkAPI.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 22/05/24.
//

import Foundation

enum NetworkingError: Error {
    case invalidUrl
    case conectionError
    case dataError
    case parseError
}

protocol Networking {
    func fetchData<T:Codable>(name: String, page: Int, completion: @escaping(Result<T, NetworkingError>) -> Void)
}

final class NetworkAPI: Networking {
    
    private var sharedUrlSession: URLSession
    
    init(sharedUrlSession: URLSession = URLSession.shared) {
        self.sharedUrlSession = sharedUrlSession
    }
    
    func fetchData<T:Codable>(name: String, page: Int, completion: @escaping(Result<T, NetworkingError>) -> Void) {
        guard let url = URL(string: Endpoint.heroes.getUrl(name, page)) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        let dataTask = sharedUrlSession.dataTask(with: url) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.conectionError))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.dataError))
                }
                return
            }
            
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            decode.dateDecodingStrategy = .iso8601
            guard let decoded = try? decode.decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.parseError))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(decoded))
            }
        }
        dataTask.resume()
    }
}
