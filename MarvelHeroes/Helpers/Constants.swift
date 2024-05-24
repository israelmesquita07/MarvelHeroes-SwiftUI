//
//  Constants.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 23/05/24.
//

import Foundation

enum Endpoint {
    case heroes
    
    static let basepath = "http://gateway.marvel.com/v1/public/characters?"
    static func offset(_ offset: Int, with limit: Int) -> String {
        "offset=\(offset)&limit=\(limit)&"
    }
    static func getUrl(_ name:String, _ page:Int) -> String {
        let limit = 50
        let offset = page * limit
        var startsWith: String = ""
        if !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        }
        return "\(basepath)\(Endpoint.offset(offset, with: limit))\(startsWith)\(Credentials.getCredentials())"
    }
}

enum Credentials {
    static let privateKey = "cd00c969a6285e3cc4992ff41ea4f4c8b3a42ddc"
    static let publicKey = "2bb07766e1619e2a92851dab2427de2b"
    
    static func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts+privateKey+publicKey).md5Value.lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
