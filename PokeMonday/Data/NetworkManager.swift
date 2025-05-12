//
//  NetworkManager.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import Foundation
import RxSwift

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}

    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
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
