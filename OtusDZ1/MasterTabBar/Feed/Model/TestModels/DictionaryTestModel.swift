//
//  DictionaryTestModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/08/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

struct DictionaryTestModel: Codable {
    
    init() {}
    
    var creationTime: TimeInterval = 0
    var add1EntryTime: TimeInterval = 0
    var add5EntriesTime: TimeInterval = 0
    var add10EntriesTime: TimeInterval = 0
    var remove1EntryTime: TimeInterval = 0
    var remove5EntriesTime: TimeInterval = 0
    var remove10EntriesTime: TimeInterval = 0
    var lookup1EntryTime: TimeInterval = 0
    var lookup10EntriesTime: TimeInterval = 0
}
