//
//  ArrayTestsModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/08/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

struct ArrayTestModel: Codable {
    
    init() {}
    
    var creationTime: TimeInterval = 0
    var insertAt0Time: TimeInterval = 0
    var insertAtMidTime: TimeInterval = 0
    var insertAtEndTime: TimeInterval = 0
    var removeAt0Time: TimeInterval = 0
    var removeAtMidTime: TimeInterval = 0
    var removeAtEndTime: TimeInterval = 0
    var lookupByIndexTime: TimeInterval = 0
    var lookupByObjectTime: TimeInterval = 0
}
