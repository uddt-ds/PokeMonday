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

    private var disposeBag = DisposeBag()

    private let viewModel = MainViewModel()

    private var limitPokeData = [LimitPokeData.shortInfoResult]()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.setCompositionalLayout()
    )

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

        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: MainCollectionViewCell.self)
        )
        collectionView.backgroundColor = .darkRed
    }

    override func setupConstraints() {
        super.setupConstraints()

        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.size.equalTo(100)
            $0.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: CompositionalLayout 적용
    private func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createCollectionViewSection())
        return layout
    }


    // MARK: CollectionView 내부 세팅
    private func createCollectionViewSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1/4.5)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    // MARK: 데이터 바인딩하는 메서드
    private func bind() {
        viewModel.limitPokeRelay
            .asDriver(onErrorDriveWith: .empty())
            .drive(collectionView.rx.items(cellIdentifier: String(describing: MainCollectionViewCell.self), cellType: MainCollectionViewCell.self)) {
                (row, element, cell) in
                cell.updatePokeImage(imageData: element)
            }
            .disposed(by: disposeBag)

        collectionView.rx.contentOffset
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] offset in
                guard let self else { return }

                let contentHeight = self.collectionView.contentSize.height
                let collectionViewHeight = self.collectionView.bounds.height

                if offset.y > (contentHeight - collectionViewHeight - 180),
                    viewModel.isInfiniteScroll == false {
                    self.viewModel.isInfiniteScroll = true
                    self.viewModel.offsetChange()
                }
            })
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .asDriver(onErrorDriveWith: .empty())
            .drive { [weak self] indexPath in
                guard let self else { return }
                let detailVC = DetailViewController()
                let pokemonData = self.viewModel.limitPokeRelay.value
                let selectedPokemonUrl = pokemonData[indexPath.item].url
                detailVC.viewModel.fetchDetailPokeData(pokemonUrl: selectedPokemonUrl)
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
