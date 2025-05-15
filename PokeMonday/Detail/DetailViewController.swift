//
//  DetailViewController.swift
//  PokeMonday
//
//  Created by Lee on 5/14/25.
//

import UIKit
import RxSwift

final class DetailViewController: BaseViewController {

    private var detailPokeData: DetailPokeData?
    let viewModel = DetailViewModel()

    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = DetailView()
    }

    override func configureUI() {
        super.configureUI()
        view.backgroundColor = .mainRed
    }

    override func setupConstraints() {
        super.setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        viewModel.detailPokeSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                if let detailView = self?.view as? DetailView {
                    detailView.setDetailStackView(detailPokeData: data)
                }
            }, onError: { error in
                print(NetworkError.dataFetchFail)
            }).disposed(by: disposeBag)
    }
}
