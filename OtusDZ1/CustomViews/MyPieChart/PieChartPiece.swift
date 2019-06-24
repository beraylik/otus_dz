//
//  PieChartPiece.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 24/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - PieChart Value model

struct PieChartPiece {
    
    // MARK: - Properties
    
    let title: String
    let value: CGFloat
    let color: UIColor
    
    // MARK: - Initialization
    
    /// Will create random color if not passed in
    init(title: String, value: CGFloat, color: UIColor) {
        self.title = title
        self.value = value
        self.color = color
    }
}
