//
//  Error.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case failRequest
    case dataFetchFail

    var errorTitle: String {
        switch self {
        case .invalidUrl: return "잘못된 링크입니다"
        case .failRequest: return "네트워크 요청 실패"
        case .dataFetchFail: return "데이터 불러오기 실패"
        }
    }
}
