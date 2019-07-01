//
//  AlgoProvider.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

typealias AlgoSuffixed = (suffix: SuffixSequence, algoName: String)

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
    
    func sortingsSuffixed() -> [SuffixSequence] {
        return sortings().map({ (algo) -> SuffixSequence in
            return algo.suffixed()
        })
    }
    
    func sortedSiffixes() -> [AlgoSuffixed] {
        let result: [AlgoSuffixed] = sortings().map({ (algo) -> AlgoSuffixed in
            let item: AlgoSuffixed = (algo.suffixed(), algo.name)
            return item
        })

        return result.sorted(by: { $0.algoName < $1.algoName })
    }
    
}
