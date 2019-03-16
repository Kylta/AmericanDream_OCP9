//
//  ExchangeHeader.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 16/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class ExchangeHeader: UIView {

    let textField: UITextField = {
        let txtField = UITextField()
        txtField.text = "1.0"
        txtField.font = UIFont.boldSystemFont(ofSize: 16)
        txtField.keyboardType = .decimalPad
        txtField.returnKeyType = .go
        txtField.textColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    let flagLabel: UILabel = {
        let label = UILabel()
        label.text = "🇪🇺"
        label.font = UIFont(name: "Apple Color Emoji", size: 40)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let symbolLabel: UILabel = {
        let label = UILabel()
        label.text = "€"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelEur: UILabel = {
        let label = UILabel()
        label.text = "EUR"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .lightBlue

        addSubview(textField)
        [textField.topAnchor.constraint(equalTo: topAnchor),
         textField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
         textField.widthAnchor.constraint(equalToConstant: 200),
         textField.heightAnchor.constraint(equalToConstant: 50)].forEach({$0.isActive = true})

        addSubview(flagLabel)
        [flagLabel.topAnchor.constraint(equalTo: topAnchor),
         flagLabel.rightAnchor.constraint(equalTo: rightAnchor),
         flagLabel.widthAnchor.constraint(equalToConstant: 80),
         flagLabel.heightAnchor.constraint(equalToConstant: 50)].forEach({$0.isActive = true})

        addSubview(symbolLabel)
        [symbolLabel.topAnchor.constraint(equalTo: topAnchor),
         symbolLabel.rightAnchor.constraint(equalTo: flagLabel.leftAnchor),
         symbolLabel.widthAnchor.constraint(equalToConstant: 80),
         symbolLabel.heightAnchor.constraint(equalToConstant: 50)].forEach({$0.isActive = true})

        addSubview(labelEur)
        [labelEur.topAnchor.constraint(equalTo: topAnchor),
         labelEur.rightAnchor.constraint(equalTo: symbolLabel.leftAnchor),
         labelEur.widthAnchor.constraint(equalToConstant: 80),
         labelEur.heightAnchor.constraint(equalToConstant: 50)].forEach({$0.isActive = true})

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
