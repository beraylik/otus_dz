//
//  BenchmarkCell.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

final class BenchmarkCell: UICollectionViewCell {

    private var timer: Timer?
    private var algo: Algo?
    private var intervalOn: TimeInterval = 0
    private var intervalOff: TimeInterval = 1
    private var algoIsOn = false
    
    
    static let cellId = String(describing: BenchmarkCell.self)
    static let nib = UINib(nibName: String(describing: BenchmarkCell.self), bundle: nil)
    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var charView: MyPieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
    }
    
    deinit {
        dropTimer()
    }
    
    func update(algo: Algo) {
        self.algo = algo
        label.text = algo.name
        backgroundColor = algo.color
        intervalOn = algo.intervalOn
        intervalOff = algo.intervalOff
        
        charView.backgroundColor = algo.color
        charView.setSize(diameter: frame.height / 3)
        updateChartData()
    }
    
    private func updateChartData() {
        let chartData = [
            PieChartPiece(title: "OFF", value: CGFloat(intervalOff), color: UIColor.cyan),
            PieChartPiece(title: "ON", value: CGFloat(intervalOn), color: UIColor.yellow)
        ]
        charView.updateValues(chartData)
        charView.setNeedsDisplay()
    }
    
    @objc func runTimed() {
        guard let timer = timer else {
            timerLabel.text = "00:00"
            return
        }
        if algoIsOn {
            intervalOn += timer.timeInterval
            algo?.intervalOn = intervalOn
            timerLabel.text = timeString(time: intervalOn)
        } else {
            intervalOff += timer.timeInterval
            algo?.intervalOff = intervalOff
        }
        updateChartData()
    }
    
    func toggleTimer() {
        algoIsOn = !algoIsOn
    }
    
    func dropTimer() {
        timer?.invalidate()
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}
