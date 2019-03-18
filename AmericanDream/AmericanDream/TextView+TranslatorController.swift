//
//  TextView+TranslatorController.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

extension TranslatorController: UITextViewDelegate {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fetch(text: translatorView.topTextView.text)
        self.view.endEditing(true)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            fetch(text: translatorView.topTextView.text)
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
