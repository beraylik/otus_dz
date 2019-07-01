//
//  SuffixSequence.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    
    let string: String
    let last: String.Index
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        last = string.endIndex
        offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < last else {
            return nil
        }
        let sub: Substring = string[offset..<last]
        string.formIndex(after: &offset)
        
        return sub
    }
}

struct SuffixSequence: Sequence {
    let string: String
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}
