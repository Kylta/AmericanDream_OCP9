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
    let model = TranslateModel(translatedText: "")
    var languageTranslation = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        setupUI()

        translatorView.pickerBotLanguage.delegate = self
        translatorView.pickerBotLanguage.dataSource = self
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

extension TranslatorController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.data.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(40)
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabelBot = UILabel()
        pickerLabelBot.text = model.data[row]
        pickerLabelBot.textAlignment = .center

        if let text = pickerLabelBot.text {
            languageTranslation = text
            return pickerLabelBot
        }

        return pickerLabelBot
    }
}
