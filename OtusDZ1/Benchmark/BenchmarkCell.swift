//
//  BenchmarkCell.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class BenchmarkCell: UICollectionViewCell {

    private var timer: Timer?
    private var interval: TimeInterval = 0
    
    static let cellId = String(describing: BenchmarkCell.self)
    static let nib = UINib(nibName: String(describing: BenchmarkCell.self), bundle: nil)
    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropTimer()
    }
    
    deinit {
        dropTimer()
    }
    
    func update(name: String, color: UIColor) {
        label.text = name
        backgroundColor = color
    }
    
    @objc func runTimed() {
        guard let timer = timer else {
            timerLabel.text = "00:00"
            return
        }
        interval += timer.timeInterval
        timerLabel.text = timeString(time: interval)
    }
    
    func toggleTimer() {
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
        } else {
            activityIndicator.stopAnimating()
            timer?.invalidate()
        }
    }
    
    func dropTimer() {
        activityIndicator.stopAnimating()
        timer?.invalidate()
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

}
