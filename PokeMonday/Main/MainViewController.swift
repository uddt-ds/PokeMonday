//
//  MainViewController.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit
import SnapKit
import RxSwift

final class MainViewController: BaseViewController {

    private let logoImageView = UIImageView()

    private let disposeBag = DisposeBag()

    private let viewModel = MainViewModel()

    private var limitPokeData = [LimitPokeData.shortInfoResult]()
    private var detailPokeData = [DetailPokeData]()

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setCompositionalLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func configureUI() {
        super.configureUI()

        view.backgroundColor = .mainRed

        [logoImageView, collectionView].forEach {
            view.addSubview($0)
        }
        logoImageView.image = UIImage(named: "pokemonBall")

        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MainCollectionViewCell.self))
        collectionView.backgroundColor = .darkRed
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setupConstraints() {
        super.setupConstraints()

        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(100)
            $0.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }


    private func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createCollectionViewSection())
        return layout
    }


    private func createCollectionViewSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1/5)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    private func bind() {
        viewModel.limitPokeSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] limitData in
                self?.limitPokeData = limitData
                self?.collectionView.reloadData()
            }, onError: { error in
                print(NetworkError.dataFetchFail)
            }).disposed(by: disposeBag)
    }

}

extension MainViewController: UICollectionViewDelegate {
    // 작성 예정
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        limitPokeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCollectionViewCell.self), for: indexPath) as? MainCollectionViewCell else { return .init() }
        cell.updatePokeImage(imageData: limitPokeData[indexPath.row])
        return cell
    }
}
