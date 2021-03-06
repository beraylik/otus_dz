//
//  BenchmarkBehavior.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - Behavior

final class BenchmarkBehavior: ViewControllerLifecycleBehavior {
    
    var timer: Timer?
    
    func afterAppearing(_ viewController: UIViewController) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
    }
    
    func afterDisappearing(_ viewController: UIViewController) {
        timer?.invalidate()
        if let vc = viewController as? BenchmarkViewController {
            vc.clearData()
        }
    }
    
    @objc func runTimed() {
        NotificationCenter.default.post(name: .timerTick, object: timer)
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
        timer?.invalidate()
    }
}
