//
//  ExchangeController.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 16/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class ExchangeRateTableViewController: UITableViewController, UITextFieldDelegate {

    let exchangeHeader = ExchangeHeader()
    let exchangeCell = ExchangeCell()
    var exchangeModel: ExchangeModel?


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Exchange Rate"
        view.backgroundColor = .lightBlue
        exchangeHeader.textField.delegate = self
        settingTableView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }

    override func viewWillAppear(_ animated: Bool) {
        fetch(number: Double(exchangeHeader.textField.text!)!)
    }

    @objc private func dismissKeyboard() {
        exchangeHeader.textField.resignFirstResponder()
        guard let text = exchangeHeader.textField.text?.replacingOccurrences(of: ",", with: ".") else { return }
        fetch(number: Double(text)!)

    }

    private func fetch(number: Double) {
        ServiceExchange.shared.downloadFromServer(value: number, completionHandler: { exchange in
            DispatchQueue.main.async { [weak self] in
                self?.exchangeModel = exchange
                self?.tableView.reloadData()
            }
        })
    }

    private func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExchangeCell.self, forCellReuseIdentifier: "cellId")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
}

extension ExchangeRateTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeModel?.currency.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return exchangeHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ExchangeCell
        guard let exchangeModel = exchangeModel else { return UITableViewCell() }

        cell.numberLabel.text = String(describing: exchangeModel.currenciesValues[indexPath.row])
        cell.textLabelName.text = exchangeModel.currenciesKeys[indexPath.row]
        cell.flagLabel.text = exchangeModel.emojiFlags[indexPath.row]
        cell.symbolLabel.text = exchangeModel.symbolCurrencies[indexPath.row]

        return cell
    }
}
