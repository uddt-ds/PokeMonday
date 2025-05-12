//
//  DetailPokeData.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation

struct DetailPokeData: Decodable {
    let height: Int
    let id: Int
    let name: String
    let species: Species
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

extension DetailPokeData {
    struct Species: Decodable {
        let name: String
        let url: String
    }

    struct Sprites: Decodable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct TypeElement: Decodable {
        let slot: Int
        let type: pokeType
    }
}

extension DetailPokeData.TypeElement {
    struct pokeType: Decodable {
        let name: String
        let url: String
    }
}

