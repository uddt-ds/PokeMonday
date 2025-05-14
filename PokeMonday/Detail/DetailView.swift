//
//  DetailStackView.swift
//  PokeMonday
//
//  Created by Lee on 5/14/25.
//

import UIKit
import SnapKit

final class DetailView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let typeLabel = UILabel()
    private let heightLabel = UILabel()
    private let weightLabel = UILabel()

    private let stackView = UIStackView()

    // 목데이터
    private let samplePokedata =
    DetailPokeData(
        height: 10, id: 1, name: "샘플",
        species: DetailPokeData.Species(name: "샘플", url: ""),
        sprites: DetailPokeData.Sprites(
            other: DetailPokeData.Sprites.Other(
                officialArtwork: DetailPokeData.Sprites.Other.OfficialArtwork(
                    frontDefault: ""))),
        types: [
        DetailPokeData.TypeElement(slot: 1, type: DetailPokeData.TypeElement.pokeType(
            name: "독", url: "")),
        DetailPokeData.TypeElement(slot: 2, type: DetailPokeData.TypeElement.pokeType(
            name: "풀", url: ""))], weight: 10
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setDetailStackView(detailPokeData: samplePokedata)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        self.addSubview(stackView)

        [imageView, titleLabel, typeLabel, heightLabel, weightLabel].forEach {
            stackView.addArrangedSubview($0)
        }

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .darkRed
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 40, leading: 0, bottom: 40, trailing: 0)

        titleLabel.font = .boldSystemFont(ofSize: 40)
        titleLabel.textColor = .white

        [typeLabel, heightLabel, weightLabel].forEach {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 25)
        }
    }

    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(300)
        }

        imageView.snp.makeConstraints {
            $0.size.equalTo(180)
        }
    }

    func setDetailStackView(detailPokeData: DetailPokeData) {
        imageView.image = UIImage(systemName: "questionmark")
        titleLabel.text = "No.\(detailPokeData.id) \(detailPokeData.name)"
        typeLabel.text = "\(detailPokeData.types[0].type.name), \(detailPokeData.types[1].type.name)"
        heightLabel.text = "\(detailPokeData.height)"
        weightLabel.text = "\(detailPokeData.weight)"
    }
}
