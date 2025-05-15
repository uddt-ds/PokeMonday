//
//  BaseViewController.swift
//  PokeMonday
//
//  Created by Lee on 5/12/25.
//

import UIKit

//MARK: 학습 차원에서 적용한 BaseViewController
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
    }

    func setupConstraints() {

    }
}
