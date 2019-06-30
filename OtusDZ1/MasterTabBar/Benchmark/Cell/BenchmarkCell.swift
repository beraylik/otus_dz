//
//  BenchmarkCell.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

final class BenchmarkCell: UICollectionViewCell {

    private var algo: Algo?
    private var algoIsOn: Bool?
    
    static let cellId = String(describing: BenchmarkCell.self)
    static let nib = UINib(nibName: String(describing: BenchmarkCell.self), bundle: nil)
    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var charView: MyPieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(runTimed(sender:)), name: .timerTick, object: nil)
    }
    
    deinit {
        dropTimer()
    }
    
    func update(algo: Algo) {
        self.algo = algo
        label.text = algo.name
        backgroundColor = algo.color
        
        let textColor: UIColor = algo.color.preffersDarkContent ? .black : .white
        label.textColor = textColor
        timerLabel.textColor = textColor
        
        charView.backgroundColor = algo.color
        charView.setSize(diameter: frame.height / 3)
        updateChartData()
    }
    
    private func updateChartData() {
        guard let algo = algo else {
            return
        }
        let chartData = [
            PieChartPiece(title: "ON", value: CGFloat(algo.intervalOn), color: UIColor.niceGreen),
            PieChartPiece(title: "OFF", value: CGFloat(algo.intervalOff), color: UIColor.niceRed)
        ]
        charView.updateValues(chartData)
        charView.setNeedsDisplay()
    }
    
    @objc func runTimed(sender: Any) {
        guard
            let notif = sender as? NSNotification,
            let timer = notif.object as? Timer,
            let algo = algo
        else {
            timerLabel.text = "00:00"
            return
        }
        if algoIsOn == true {
            algo.intervalOn += timer.timeInterval
            timerLabel.text = timeString(time: algo.intervalOn)
        } else if algoIsOn == false {
            algo.intervalOff += timer.timeInterval
        }
        updateChartData()
    }
    
    func toggleTimer() {
        algoIsOn = !(algoIsOn ?? false)
    }
    
    func dropTimer() {
        NotificationCenter.default.removeObserver(self, name: .timerTick, object: nil)
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}
