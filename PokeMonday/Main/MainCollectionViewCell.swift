//
//  MainViewCell.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit
import SnapKit
import Kingfisher

final class MainCollectionViewCell: BaseCollectionViewCell {

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureUI() {
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.frame = contentView.bounds
        imageView.backgroundColor = .white
    }

    func updatePokeImage(imageData: LimitPokeData.shortInfoResult) {
        // 추후 url 길이에 따라 suffix int값 변경 예정
        var rawId = imageData.url.suffix(5)
        let id = rawId.filter { $0.isNumber }
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png") else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.imageView.kf.setImage(with: url)
        }
    }
}
