//
//  BaseCollectionViewCell.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit

//MARK: 학습 차원에서 적용한 BaseCollectionViewCell
class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {

    }

//    func setupConstraints() {
//
//    }
}
