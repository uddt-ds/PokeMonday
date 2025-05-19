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

    private let leftBtn = UIButton()
    private let rightBtn = UIButton()
    private let upBtn = UIButton()
    private let downBtn = UIButton()
    private let selectABtn = UIButton()
    private let selectBBtn = UIButton()

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

        [leftBtn, rightBtn, upBtn, downBtn].forEach {
            self.addSubview($0)
            setButton(btn: $0, radius: 9)
            leftBtn.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
            
            rightBtn.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
            upBtn.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
            downBtn.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }

        [selectABtn, selectBBtn].forEach {
            self.addSubview($0)
            selectABtn.setTitle("A", for: .normal)
            selectBBtn.setTitle("B", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            setButton(btn: $0, radius: 22)
        }


        leftBtn.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(137)
            $0.bottom.equalTo(self.snp.bottom).offset(-163)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(54)
            $0.width.equalTo(50)
        }

        rightBtn.snp.makeConstraints {
            $0.top.equalTo(leftBtn.snp.top)
            $0.bottom.equalTo(leftBtn.snp.bottom)
            $0.leading.equalTo(leftBtn.snp.trailing).offset(34)
            $0.width.equalTo(50)
        }

        upBtn.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(87)
            $0.height.equalTo(50)
            $0.leading.equalTo(leftBtn.snp.trailing)
            $0.trailing.equalTo(rightBtn.snp.leading)
        }

        downBtn.snp.makeConstraints {
            $0.top.equalTo(upBtn.snp.bottom).offset(34)
            $0.height.equalTo(50)
            $0.leading.equalTo(upBtn.snp.leading)
            $0.trailing.equalTo(upBtn.snp.trailing)
        }

        selectABtn.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.equalTo(stackView.snp.bottom).offset(111)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(45)
            $0.bottom.equalTo(selectBBtn.snp.top).inset(5)
        }

        selectBBtn.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(88)
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

            DispatchQueue.main.async { [weak self] in
                self?.imageView.kf.setImage(with: url)
                let pokemonName = detailPokeData.name
                let koreanName = PokemonTranslator.getKoreanName(for: pokemonName)
                self?.titleLabel.text = "No.\(detailPokeData.id) \(koreanName)"

                guard let pokemonType = PokemonTypeName(rawValue: detailPokeData.types[0].type.name)?.displayName else {
                    return
                }

                if detailPokeData.types.count == 2 {
                    guard let pokemonType2 = PokemonTypeName(rawValue: detailPokeData.types[1].type.name)?.displayName else {
                        return
                    }
                    self?.typeLabel.text = "타입: \(pokemonType), \(pokemonType2)"
                } else {
                    self?.typeLabel.text = "타입: \(pokemonType)"
                }

                let height = Measurement(value: (Double(detailPokeData.height) / 10),
                                         unit: UnitLength.meters)
                self?.heightLabel.text = "키: \(height)"

                let weight = Measurement(value: (Double(detailPokeData.weight) / 10),
                                         unit: UnitMass.kilograms)
                self?.weightLabel.text = "몸무게: \(weight)"
            }
        }
    }

    private func setButton(btn: UIButton, radius: Double) {
        btn.backgroundColor = .btnBackgroundColor
        btn.layer.cornerRadius = radius
    }
}
