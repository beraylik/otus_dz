//
//  Component.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 03/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class Component: UIView {

    var view: UIView? = nil
    
    @IBInspectable var bgColor: UIColor = UIColor.white {
        didSet {
            view?.backgroundColor = bgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        let bundle = Bundle.main
        let nib = bundle.loadNibNamed("Component", owner: nil, options: nil)
        if let view = nib?[0] as? UIView {
            self.view = view
            addSubview(view)
        }
    }

}
