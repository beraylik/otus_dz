//
//  ChangeImageBtn.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 03/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

@IBDesignable class ChangeImageBtn: UIButton {

    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable var borderColor: CGColor = UIColor.black.cgColor {
        didSet {
            self.layer.borderColor = borderColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
}
