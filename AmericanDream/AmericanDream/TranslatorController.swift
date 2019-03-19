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

        view.backgroundColor = .clear
        setupUI()

        translatorView.pickerBotLanguage.delegate = self
        translatorView.pickerBotLanguage.dataSource = self

        translatorView.topTextView.text = "Bonjour"
        translatorView.botTextView.text = "Hello"
        translatorView.pickerBotLanguage.selectRow(16, inComponent: 0, animated: true)

        translatorView.topTextView.delegate = self
    }

    private func setupUI() {
        translatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(translatorView)
        [translatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         translatorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
         translatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
         translatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }

    func fetch(text: String) {
        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        DispatchQueue.global(qos: .userInteractive).async {
            ServiceTranslator.shared.downloadFromServer(text: text, languageTranslation: self.languageTranslation, completionHandler: { (translator) in
                DispatchQueue.main.async {
                    self.translatorView.botTextView.text = translator.translatedText
                }
            })
        }
    }
}
