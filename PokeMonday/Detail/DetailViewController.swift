//
//  DetailViewController.swift
//  PokeMonday
//
//  Created by Lee on 5/14/25.
//

import UIKit

class DetailViewController: BaseViewController {

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
}
