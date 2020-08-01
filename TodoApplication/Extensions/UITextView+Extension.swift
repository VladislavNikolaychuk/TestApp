//
//  UITextView+Extension.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 31.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import SnapKit

extension UITextView {
    func addCancelToolbar() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: Text.send.localized,
                            style: .plain, target: self, action: #selector(cancelNumberPad))
        ]
        numberToolbar.sizeToFit()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(cancelNumberPad))
        swipeDown.direction = .down
        numberToolbar.addGestureRecognizer(swipeDown)
        self.inputAccessoryView = numberToolbar
    }
    @objc func cancelNumberPad() {
        self.endEditing(true)
    }
}

extension UITextView {
    func sizeToFitAttributedString(width: CGFloat) -> CGSize {
        let textSize = self.attributedText.size()
        let viewSize = CGSize(width: width, height: textSize.height)
        return self.sizeThatFits(viewSize)
    }
}
extension UILabel {
    func sizeToFitAttributedString(width: CGFloat) -> CGSize? {
        guard let attributedText = attributedText else {
               return nil
           }
        let textSize = attributedText.size()
        let viewSize = CGSize(width: width, height: textSize.height)
        return self.sizeThatFits(viewSize)
    }
}
extension UITextView: UITextViewDelegate {
override open var bounds: CGRect {
    didSet {
        self.resizePlaceholder()
    }
}

public var placeholder: String? {
    get {
        var placeholderText: String?
        if let placeholderLbl = self.viewWithTag(50) as? UILabel {
            placeholderText = placeholderLbl.text
        }
        return placeholderText
    }
    set {
        if let placeholderLbl = self.viewWithTag(50) as? UILabel {
            placeholderLbl.text = newValue
            placeholderLbl.sizeToFit()
        } else {
            guard let newValue = newValue else {
                return
            }
            self.addPlaceholder(newValue)
        }
    }
}

public func textViewDidChange(_ textView: UITextView) {
    if let placeholderLbl = self.viewWithTag(50) as? UILabel {
        placeholderLbl.isHidden = self.text.count > 0
    }
}

private func resizePlaceholder() {
    self.layer.borderWidth = 2.0
     self.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
     self.layer.cornerRadius = 4.0
    if let placeholderLbl = self.viewWithTag(50) as? UILabel? {
        let xLiteral = self.textContainer.lineFragmentPadding
        let yLiteral = self.textContainerInset.top - 2
        let width = self.frame.width - (xLiteral * 2)
        let height = placeholderLbl?.frame.height ?? 0.0
        placeholderLbl?.frame = CGRect(x: xLiteral, y: yLiteral, width: width, height: height)
    }
}

private func addPlaceholder(_ placeholderText: String) {
    let placeholderLbl = UILabel()
    placeholderLbl.text = placeholderText
    placeholderLbl.sizeToFit()
    placeholderLbl.font = self.font
    placeholderLbl.textColor = UIColor.lightGray
    placeholderLbl.tag = 50
    placeholderLbl.isHidden = self.text.count > 0
    self.addSubview(placeholderLbl)
    placeholderLbl.snp.makeConstraints { (make) in
        make.top.equalTo(self).offset(11.0)
        make.left.equalTo(self).offset(16.0)
        make.right.equalTo(self).offset(16.0)
    }
    self.resizePlaceholder()
    self.delegate = self
}
}
