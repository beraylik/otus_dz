//
//  BenchmarkCell.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class BenchmarkCell: UICollectionViewCell {

    static let cellId = String(describing: BenchmarkCell.self)
    static let nib = UINib(nibName: String(describing: BenchmarkCell.self), bundle: nil)
    
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(name: String, color: UIColor) {
        label.text = name
        backgroundColor = color
    }

}
