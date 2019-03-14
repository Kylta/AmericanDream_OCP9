//
//  TranslatorController.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class TranslatorController: UIViewController {

    let translatorView = TranslatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        setupUI()
    }

    private func setupUI() {
        translatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(translatorView)
        [translatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         translatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
         translatorView.rightAnchor.constraint(equalTo: view.rightAnchor),
         translatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
}
