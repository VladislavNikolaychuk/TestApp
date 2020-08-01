//
//  UITextField+Extensions.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addCancelToolbar() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: Text.done.localized,
                            style: .plain, target: self, action: #selector(cancelNumberPad))
        ]
        numberToolbar.sizeToFit()
        self.inputAccessoryView = numberToolbar
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(cancelNumberPad))
        swipeDown.direction = .down
        numberToolbar.addGestureRecognizer(swipeDown)
    }

    @objc
    func cancelNumberPad() {
        self.endEditing(true)
    }
    
}
