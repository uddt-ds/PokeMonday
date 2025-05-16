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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
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
            $0.font = .systemFont(ofSize: 20)
        }
    }

    private func setConstraints() {
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
        DispatchQueue.global().async {
            guard let url = URL(
                string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(detailPokeData.id).png"
            ) else { return }

            do {
                let image = try UIImage(data: Data(contentsOf: url))
                DispatchQueue.main.async {
                    self.imageView.image = image

                    let pokemonName = detailPokeData.name
                    let koreanName = PokemonTranslator.getKoreanName(for: pokemonName)
                    self.titleLabel.text = "No.\(detailPokeData.id) \(koreanName)"

                    guard let pokemonType = PokemonTypeName(rawValue: detailPokeData.types[0].type.name)?.displayName else {
                        return
                    }

                    if detailPokeData.types.count == 2 {
                        guard let pokemonType2 = PokemonTypeName(rawValue: detailPokeData.types[1].type.name)?.displayName else {
                            return
                        }
                        self.typeLabel.text = "타입: \(pokemonType), \(pokemonType2)"
                    } else {
                        self.typeLabel.text = "타입: \(pokemonType)"
                    }

                    let height = Measurement(value: (Double(detailPokeData.height) / 10),
                                             unit: UnitLength.meters)
                    self.heightLabel.text = "키: \(height)"

                    let weight = Measurement(value: (Double(detailPokeData.weight) / 10),
                                             unit: UnitMass.kilograms)
                    self.weightLabel.text = "몸무게: \(weight)"
                }
            } catch {
                print(NetworkError.dataFetchFail.errorTitle)
            }
        }
    }
}
