//
//  SuffixManipulator.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

/**
 * A protocol which will allow the easy test out SuffixSequence
 */
public protocol SequenceManipulator {
    func arrayHasObjects() -> Bool
    func setCustomTimes(_ count: Int)
    func lookup10times() -> TimeInterval
    func lookupCustomTimes() -> TimeInterval
}
