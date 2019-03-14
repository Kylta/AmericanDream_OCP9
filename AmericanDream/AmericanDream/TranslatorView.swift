//
//  TranslatorView.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class TranslatorView: UIView {

    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your text"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let topTextView: UITextView = {
        let txtView = UITextView()
        txtView.font = UIFont.boldSystemFont(ofSize: 16)
        txtView.layer.borderWidth = 2
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()

    let translatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Translation"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let botTextView: UITextView = {
        let txtView = UITextView()
        txtView.font = UIFont.boldSystemFont(ofSize: 16)
        txtView.layer.borderWidth = 2
        txtView.isEditable = false
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()

    let pickerBotLanguage: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .white
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)


        addSubview(textLabel)
        [textLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
         textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         textLabel.widthAnchor.constraint(equalToConstant: 200),
         textLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50)].forEach({$0.isActive = true})

        addSubview(topTextView)
        [topTextView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8),
         topTextView.leftAnchor.constraint(equalTo: leftAnchor),
         topTextView.rightAnchor.constraint(equalTo: rightAnchor),
         topTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -28)].forEach({$0.isActive = true})

        addSubview(translatorLabel)
        [translatorLabel.topAnchor.constraint(equalTo: topTextView.bottomAnchor, constant: 8),
         translatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         translatorLabel.widthAnchor.constraint(equalToConstant: 200),
         translatorLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 45)].forEach({$0.isActive = true})


        addSubview(botTextView)
        [botTextView.topAnchor.constraint(equalTo: translatorLabel.bottomAnchor, constant: 8),
         botTextView.leftAnchor.constraint(equalTo: leftAnchor),
         botTextView.rightAnchor.constraint(equalTo: rightAnchor),
         botTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})

        addSubview(pickerBotLanguage)
        [pickerBotLanguage.centerYAnchor.constraint(equalTo: translatorLabel.centerYAnchor),
         pickerBotLanguage.widthAnchor.constraint(equalToConstant: 50),
         pickerBotLanguage.leftAnchor.constraint(equalTo: translatorLabel.rightAnchor),
         pickerBotLanguage.heightAnchor.constraint(lessThanOrEqualToConstant: 40)].forEach({$0.isActive = true})
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

