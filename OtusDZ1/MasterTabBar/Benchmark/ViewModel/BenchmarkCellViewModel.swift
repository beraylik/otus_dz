//
//  BenchmarkCellViewModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 28/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class BenchmarkCellViewModel {
    
    private var algo: Algo
    
    var algoIsOn: Bool = false
    var timerText: String = "00:00"
    var algoName: String { return algo.name }
    var algoColor: UIColor { return algo.color }
    var intervalOn: CGFloat { return CGFloat(algo.intervalOn) }
    var intervalOff: CGFloat { return CGFloat(algo.intervalOff) }
    var textColor: UIColor {
        return algo.color.preffersDarkContent ? .black : .white
    }
    
    var updateEvent: (() -> Void)?
    
    init(algo: Algo) {
        self.algo = algo
        NotificationCenter.default.addObserver(self, selector: #selector(runTimed(sender:)), name: .timerTick, object: nil)
    }
    
    @objc func runTimed(sender: Any) {
        guard
            let notif = sender as? NSNotification,
            let timer = notif.object as? Timer
            else {
                timerText = "00:00"
                return
        }
        if algoIsOn == true {
            algo.intervalOn += timer.timeInterval
            timerText = timeString(time: algo.intervalOn)
        } else if algoIsOn == false {
            algo.intervalOff += timer.timeInterval
        }
        updateEvent?()
    }
    
    func toggleTimer() {
        algoIsOn = !algoIsOn
    }
    
    func dropTimer() {
        NotificationCenter.default.removeObserver(self, name: .timerTick, object: nil)
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    deinit {
        dropTimer()
    }
    
    
}

