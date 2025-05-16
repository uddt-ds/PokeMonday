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

    var isInfiniteScroll = false

    private var offset = 0

    let limitPokeSubject = BehaviorSubject(value: [LimitPokeData.shortInfoResult]())
//    var limitPokeData = [LimitPokeData.shortInfoResult]()

    init() {
        fetchLimitPokeData()
    }

    func offsetChange() {
        if !isInfiniteScroll {
            offset = 0
        } else {
            offset += 20
            fetchLimitPokeData()
            isInfiniteScroll = false
        }
    }

    private func fetchLimitPokeData() {
        
        guard let url = NetworkManager.shared.getLimitPokeUrl(limit: "20", offset: "\(offset)") else {
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
}
