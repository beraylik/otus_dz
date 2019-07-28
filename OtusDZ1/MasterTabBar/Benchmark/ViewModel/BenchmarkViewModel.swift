//
//  BenchmarkViewModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 28/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class BenchmarkViewModel {
    
    var dataSource: [BenchmarkCellViewModel] = []
    
    init() {
        dataSource = Services.algoProvider.sortings().map({ (algo) -> BenchmarkCellViewModel in
            BenchmarkCellViewModel(algo: algo)
        })
    }
    
}
