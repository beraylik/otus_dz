//
//  AlgoProvider.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class Algo {
    var name: String
    var intervalOn: TimeInterval = 0
    var intervalOff: TimeInterval = 0
    var color: UIColor
    
    init(name: String) {
        self.name = name
        self.color = UIColor.random
    }
}

struct AlgoProvider {
    
    func sortings() -> [Algo] {
        return [
            Algo(name: "Insertion Sort"),
            Algo(name: "Selection Sort"),
            Algo(name: "Shell Sort"),
            Algo(name: "Quicksort"),
            Algo(name: "Merge Sort"),
            Algo(name: "Heap Sort"),
            Algo(name: "Introsort"),
            Algo(name: "Counting Sort"),
            Algo(name: "Radix Sort"),
            Algo(name: "Topological Sort"),
            Algo(name: "Bubble Sort"),
            Algo(name: "Slow sort")
        ]
    }
    
}
