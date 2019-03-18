//
//  PickerController+TranslatorController.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

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
