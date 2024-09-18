//
//  NetworkAPI.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 22/05/24.
//

import Foundation

enum NetworkingError: Error {
    case invalidUrl
    case invalidResponse
    case conectionError
    case dataError
    case parseError
}

protocol Networking {
    func fetchData<T:Codable>(name: String, page: Int) async throws -> T
}

final class NetworkAPI: Networking {
    
    private var sharedUrlSession: URLSession
    
    init(sharedUrlSession: URLSession = URLSession.shared) {
        self.sharedUrlSession = sharedUrlSession
    }
    
    func fetchData<T:Codable>(name: String, page: Int) async throws -> T {
        guard let url = URL(string: Endpoint.heroes.getUrl(name, page)) else {
            throw NetworkingError.invalidUrl
        }
        
        let (data, response) = try await sharedUrlSession.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingError.invalidResponse
        }
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        decorder.dateDecodingStrategy = .iso8601
        
        guard let decoded = try? decorder.decode(T.self, from: data) else {
            throw NetworkingError.parseError
        }
        
        return decoded
    }
}
