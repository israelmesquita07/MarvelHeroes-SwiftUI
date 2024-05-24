//
//  MarvelInfo.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 22/05/24.
//

struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

final class Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    var _isFavorite: Bool?
    var isFavorite: Bool? {
        get {
            return self._isFavorite
        } set (newValue) {
            self._isFavorite = newValue
        }
    }
    
    init(id: Int, name: String, description: String, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}

struct Thumbnail: Codable {
    let path: String
    let ext: String
    var url: String {
        return path + "." + ext
    }
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
