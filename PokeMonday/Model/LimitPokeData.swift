//
//  LimitPokemon.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation

struct LimitPokeData: Decodable {
    let count: Int
    let next: String
    let results: [shortInfoResult]
}

extension LimitPokeData {
    struct shortInfoResult: Decodable {
        let name: String
        let url: String
    }
}
