//
//  LimitPokemon.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation

// MainViewModel에서 사용하는 제한된 포켓몬 데이터
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
