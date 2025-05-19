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

    // 무한 스크롤 적용을 위한 Flag
    var isInfiniteScroll = false

    init() {
        fetchLimitPokeData()
    }

    // url 뒤에 들어가는 offset 값을 변경해주는 메서드
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
