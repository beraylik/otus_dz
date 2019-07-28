//
//  BenchmarkCell.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

final class BenchmarkCell: UICollectionViewCell {

    private var viewModel: BenchmarkCellViewModel?
    
    static let cellId = String(describing: BenchmarkCell.self)
    static let nib = UINib(nibName: String(describing: BenchmarkCell.self), bundle: nil)
    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var charView: MyPieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: BenchmarkCellViewModel) {
        self.viewModel = viewModel
        
        viewModel.updateEvent = { [weak self] in
            guard let vm = self?.viewModel else { return }
            self?.timerLabel.text = vm.timerText    
            self?.updateChartData(onInterval: vm.intervalOn, offInterval: vm.intervalOff)
        }
        
        label.text = viewModel.algoName
        label.textColor = viewModel.textColor
        timerLabel.textColor = viewModel.textColor
        backgroundColor = viewModel.algoColor
        charView.backgroundColor = viewModel.algoColor
        charView.setSize(diameter: frame.height / 3)
        updateChartData(onInterval: viewModel.intervalOn, offInterval: viewModel.intervalOff)
    }
    
    private func updateChartData(onInterval: CGFloat, offInterval: CGFloat) {
        let chartData = [
            PieChartPiece(title: "ON", value: onInterval, color: UIColor.niceGreen),
            PieChartPiece(title: "OFF", value: offInterval, color: UIColor.niceRed)
        ]
        charView.updateValues(chartData)
        charView.setNeedsDisplay()
    }
    
}
