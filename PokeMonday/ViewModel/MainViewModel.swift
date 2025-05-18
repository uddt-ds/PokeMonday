//
//  MainViewModel.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewModel {

    private var disposeBag = DisposeBag()

    let limitPokeRelay = BehaviorRelay(value: [LimitPokeData.shortInfoResult]())

    private var offset = 0

    var isInfiniteScroll = false

    init() {
        fetchLimitPokeData()
    }

    func offsetChange() {
        if !isInfiniteScroll {
            offset = 0
        } else {
            offset += 20
            fetchLimitPokeData()
        }
    }

    private func fetchLimitPokeData() {
        guard let url = NetworkManager.shared.getLimitPokeUrl(limit: "20", offset: "\(offset)") else {
            return
        }

        NetworkManager.shared.fetch(url: url)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] (data: LimitPokeData) in
                guard let currentData = self?.limitPokeRelay.value else { return () }
                self?.limitPokeRelay.accept(currentData + data.results)
                self?.isInfiniteScroll = false
            })
            .disposed(by: disposeBag)
    }
}
