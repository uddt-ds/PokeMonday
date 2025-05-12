//
//  MainViewModel.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit
import RxSwift

class MainViewModel {

    private let disposeBag = DisposeBag()

    let limitPokeSubject = BehaviorSubject(value: [LimitPokeData]())
    let DetailPokeSubject = BehaviorSubject(value: [DetailPokeData]())

    init() {
        fetchLimitPokeData()
    }

    func fetchLimitPokeData() {
        guard let url = NetworkManager.shared.getLimitPokeUrl(limit: "20", offset: "0") else {
            limitPokeSubject.onError(NetworkError.invalidUrl)
            return
        }

        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self]
                (limitPokeData: LimitPokeData) in
                self?.limitPokeSubject.onNext([limitPokeData])
            }, onFailure: { [weak self] error in
                self?.limitPokeSubject
                    .onError(NetworkError.dataFetchFail)
            }).disposed(by: disposeBag)
    }
}
