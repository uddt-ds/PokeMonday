//
//  MainViewModel.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit
import RxSwift

final class MainViewModel {

    private let disposeBag = DisposeBag()

    let limitPokeSubject = BehaviorSubject(value: [LimitPokeData.shortInfoResult]())
//    let DetailPokeSubject = BehaviorSubject(value: [DetailPokeData]())

    init() {
        fetchLimitPokeData()
//        fetchDetailPokeData()
    }

    func fetchLimitPokeData() {
        guard let url = NetworkManager.shared.getLimitPokeUrl(limit: "20", offset: "0") else {
            limitPokeSubject.onError(NetworkError.invalidUrl)
            return
        }

        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self]
                (limitPokeData: LimitPokeData) in
                self?.limitPokeSubject.onNext(limitPokeData.results)
            }, onFailure: { [weak self] error in
                self?.limitPokeSubject
                    .onError(NetworkError.dataFetchFail)
            }).disposed(by: disposeBag)
    }

//    func fetchDetailPokeData(pokemonName: String? = nil) {
//        if let pokemonName {
//            guard let url = NetworkManager.shared.detailPokeUrl(pokemonName: pokemonName) else {
//                DetailPokeSubject.onError(NetworkError.invalidUrl)
//                return
//            }
//
//            NetworkManager.shared.fetch(url: url)
//                .subscribe(onSuccess: { [weak self]
//                    (detailPokeData: DetailPokeData) in
//                    self?.DetailPokeSubject.onNext([detailPokeData])
//                }, onFailure: { [weak self] error in
//                    self?.DetailPokeSubject
//                        .onError(NetworkError.dataFetchFail)
//                }).disposed(by: disposeBag)
//        }
//    }

}
