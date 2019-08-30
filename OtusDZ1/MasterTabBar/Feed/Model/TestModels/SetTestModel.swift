//
//  SetTestModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/08/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

struct SetTestModel: Codable {
    init() {}
    
    var creationTime: TimeInterval = 0
    var add1ObjectTime: TimeInterval = 0
    var add5ObjectsTime: TimeInterval = 0
    var add10ObjectsTime: TimeInterval = 0
    var remove1ObjectTime: TimeInterval = 0
    var remove5ObjectsTime: TimeInterval = 0
    var remove10ObjectsTime: TimeInterval = 0
    var lookup1ObjectTime: TimeInterval = 0
    var lookup10ObjectsTime: TimeInterval = 0
}
