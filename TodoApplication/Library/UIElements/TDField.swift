//
//  TDField.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

protocol Validable: class {
    func setToValid()
    func setToInvalid()
}

final class TDField: UITextField, Validable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setToValid() {
        self.layer.borderColor = Colors.darkColor.cgColor
    }
    
    func setToInvalid() {
        self.layer.borderColor = Colors.dangerColor.cgColor
    }
    
    private func setup() {
        self.layer.borderColor = Colors.darkColor.cgColor
        self.layer.borderWidth = 1.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.borderStyle = .roundedRect
        self.textColor = Colors.darkColor
        self.addCancelToolbar()
    }
    
}
