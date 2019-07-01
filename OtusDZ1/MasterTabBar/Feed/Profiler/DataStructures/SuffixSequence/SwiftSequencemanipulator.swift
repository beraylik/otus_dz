//
//  SwiftSequencemanipulator.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class SwiftSequenceManipulator: SequenceManipulator {
    
    fileprivate var data = [AlgoSuffixed]()
    fileprivate var targetLookups: Int = 0
    
    func setCustomTimes(_ count: Int) {
        targetLookups = count
        data = Services.algoProvider.sortedSiffixes()
    }
    
    func arrayHasObjects() -> Bool {
        return !data.isEmpty
    }
    
    //MARK: Look up Tests
    
    func lookup10times() -> TimeInterval {
        let stringGenerator = StringGenerator()
        let time = Profiler.runClosureForTime {
            for _ in 0..<10 {
                let randString = stringGenerator.generateRandomString(3)
                
                for algo in self.data {
                    let _ = algo.suffix.contains(Substring(randString))
                }
            }
        }
        return time
    }
    
    func lookupCustomTimes() -> TimeInterval {
        var foundInTotal = 0
        let stringGenerator = StringGenerator()
        let time = Profiler.runClosureForTime {
            while foundInTotal < self.targetLookups {
                let randString = stringGenerator.generateRandomString(3)
                for algo in self.data {
                    var iterator = algo.suffix.makeIterator()
                    while let substring = iterator.next() {
                        if substring == randString {
                            foundInTotal += 1
                            print("Found with: \(randString)")
                            break
                        }
                    }
                }
            }
            
        }
        return time
    }
    
}
