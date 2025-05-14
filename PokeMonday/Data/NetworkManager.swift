//
//  NetworkManager.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation
import RxSwift

// 추후 RxURLSession 공부 후 적용 예정
//MARK: 네트워크 담당하는 클래스
final class NetworkManager {

    static let shared = NetworkManager()
    private init() {}

    private func makeUrl(path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "pokeapi.co"
        component.path = path
        component.queryItems = queryItems

        return component.url
    }

    func getLimitPokeUrl(limit: String, offset: String) -> URL? {
        let path = "/api/v2/pokemon"
        let queryItems = [
            URLQueryItem(name: "limit", value: limit),
            URLQueryItem(name: "offset", value: offset)
        ]
        return makeUrl(path: path, queryItems: queryItems)
    }

    func detailPokeUrl(pokemonName: String) -> URL? {
        let path = "/api/v2/pokemon"
        return makeUrl(path: "\(path)/\(pokemonName)")
    }

    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = ["Content-type": "application/json"]
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.failure(NetworkError.invalidUrl))
                    return
                }

                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer(.success(decodedData))
                } catch {
                    observer(.failure(NetworkError.dataFetchFail))
                }
            }
            task.resume()

            return Disposables.create()
        }
    }
}
