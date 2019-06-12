//
//  BenchmarkViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 12/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - Behavior

final class BenchmarkBehavior: ViewControllerLifecycleBehavior {
    
    private var delegate: BenchmarkProtocol
    
    init(delegate: BenchmarkProtocol) {
        self.delegate = delegate
    }
    
    func afterAppearing(_ viewController: UIViewController) {
        delegate.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
    }
    
    @objc func runTimed() {
        print(Date())
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
        delegate.timer?.invalidate()
    }
}

// MARK: - Protocol

protocol BenchmarkProtocol {
    
    var timer: Timer? { get set }
    
}

// MARK: - ViewController

class BenchmarkViewController: UIViewController, BenchmarkProtocol {
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBehaviors(behaviors: [BenchmarkBehavior(delegate: self)])
    }

}
