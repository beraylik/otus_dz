//
//  Algo.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class Algo {
    var name: String
    var intervalOn: TimeInterval = 0
    var intervalOff: TimeInterval = 1
    var color: UIColor
    
    init(name: String) {
        self.name = name
        self.color = UIColor.random
    }
}
