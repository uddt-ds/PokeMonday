//
//  DetailViewModel.swift
//  PokeMonday
//
//  Created by Lee on 5/14/25.
//

import UIKit
import RxSwift

final class DetailViewModel {

    private let disposeBag = DisposeBag()

    let detailPokeSubject: PublishSubject<DetailPokeData>

    init(detailPokeSubject: PublishSubject<DetailPokeData>) {
        self.detailPokeSubject = detailPokeSubject
        fetchDetailPokeData()
    }


    func fetchDetailPokeData(pokemonName: String? = nil) {
        guard let pokemonName else {
            return
        }
        guard let url = NetworkManager.shared.detailPokeUrl(pokemonName: pokemonName) else {
            detailPokeSubject.onError(NetworkError.invalidUrl)
            return
        }

        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (detailPokeData: DetailPokeData) in
                self?.detailPokeSubject.onNext(detailPokeData)
            }, onFailure: { [weak self] error in
                self?.detailPokeSubject.onError(NetworkError.dataFetchFail)
            }).disposed(by: disposeBag)
    }

}
