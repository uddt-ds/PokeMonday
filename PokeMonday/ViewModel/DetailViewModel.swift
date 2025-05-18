//
//  DetailViewModel.swift
//  PokeMonday
//
//  Created by Lee on 5/14/25.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewModel {

    private var disposeBag = DisposeBag()

    let detailPokeRelay = BehaviorRelay<DetailPokeData?>(value: nil)

    func fetchDetailPokeData(pokemonUrl: String) {
        
        guard let url = URL(string: pokemonUrl) else {
            return
        }

        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (detailPokeData: DetailPokeData) in
                self?.detailPokeRelay.accept(detailPokeData)
            }).disposed(by: disposeBag)
    }

}
