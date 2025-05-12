//
//  Error.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case dataFetchFail

    var errorTitle: String {
        switch self {
        case .invalidUrl: return "잘못된 링크입니다"
        case .dataFetchFail: return "데이터 패치 실패"
        }
    }
}
