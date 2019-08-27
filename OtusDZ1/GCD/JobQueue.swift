//
//  JobQueue.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 14/08/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class JobQueue {
    
    var task: (() -> TimeInterval)?
    
    var executionTime: TimeInterval = 0
    
    func execute() {
        guard let task = task else { return }
        let time = task()
        executionTime = time
    }
    
}
