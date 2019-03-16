//
//  ExchangeCell.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 16/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class ExchangeCell: UITableViewCell {

    var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let flagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple Color Emoji", size: 40)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textLabelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .darkBlue

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

        addSubview(textLabelName)
        [textLabelName.topAnchor.constraint(equalTo: topAnchor),
         textLabelName.rightAnchor.constraint(equalTo: symbolLabel.leftAnchor),
         textLabelName.widthAnchor.constraint(equalToConstant: 80),
         textLabelName.heightAnchor.constraint(equalToConstant: 50)].forEach({$0.isActive = true})

        addSubview(numberLabel)
        [numberLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
         numberLabel.topAnchor.constraint(equalTo: topAnchor),
         numberLabel.rightAnchor.constraint(equalTo: textLabelName.leftAnchor, constant: -8),
         numberLabel.heightAnchor.constraint(equalToConstant: 50)].forEach({$0.isActive = true})
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

