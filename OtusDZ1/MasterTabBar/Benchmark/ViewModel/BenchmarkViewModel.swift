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
        guard let algoProvider: AlgoProvider = ServiceLocator.shared.getService() else {
            dataSource = []
            return
        }
        dataSource = algoProvider.sortings().map({ (algo) -> BenchmarkCellViewModel in
            BenchmarkCellViewModel(algo: algo)
        })
    }
    
}
