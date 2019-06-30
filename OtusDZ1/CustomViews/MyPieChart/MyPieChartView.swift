//
//  MyPieChart.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 24/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - PieChart View

@IBDesignable
final class MyPieChartView: UIView {
    
    // MARK: - Properties
    
    private var values: [PieChartPiece] = []
    private var diameter: CGFloat = 0
    private var spacing: CGFloat = 1
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .font               : UIFont.systemFont(ofSize: 14),
        .foregroundColor    : UIColor.black
    ]
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set diameter of the smallest side by default
        let diameter = min(frame.width, frame.height)
        setSize(diameter: diameter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View life cycle
    
    override func draw(_ rect: CGRect) {
        drawChart()
    }
    
    override func prepareForInterfaceBuilder() {
        setNeedsDisplay()
    }
    
    // MARK: - Public interface
    
    func updateValues(_ values: [PieChartPiece]) {
        self.values = values
        drawChart()
    }
    
    func setSize(diameter: CGFloat, spacing: CGFloat = 1) {
        self.diameter = diameter
        self.spacing = spacing
        
        drawChart()
    }
    
    // MARK: - Drawing helpers
    
    private func drawChart() {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let radius = diameter / 2
        let textPositionOffset: CGFloat = 0.5
        let viewCenter = bounds.center
        
        let totalSegmentsValue = values.reduce(0, { $0 + $1.value })
        var startAngle = -CGFloat.pi * 0.5
        
        for segment in values {
            context.setFillColor(segment.color.cgColor)
            
            // Draw a slice
            let endAngle = startAngle + 2 * .pi * (segment.value / totalSegmentsValue)
            context.move(to: viewCenter)
            context.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.fillPath()
            
            // Draw a delimiter
            context.move(to: viewCenter)
            context.addLine(to: CGPoint(center: viewCenter, radius: radius, degrees: endAngle))
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(spacing)
            context.strokePath()
            
            // Draw a label
            let halfAngle = startAngle + (endAngle - startAngle) * 0.5
            let segmentCenter = viewCenter.projected(by: radius * textPositionOffset, angle: halfAngle)
            let textToRender = prepareTitleFor(segment)
            let renderRect = CGRect(centeredOn: segmentCenter, size: textToRender.size())
            textToRender.draw(in: renderRect)
            
            startAngle = endAngle
        }
        
    }
    
    // MARK: - Content helpers
    
    private func prepareTitleFor(_ segment: PieChartPiece) -> NSAttributedString {
        let textColor: UIColor = segment.color.preffersDarkContent ? .black : .white
        let subTextColor: UIColor = segment.color.preffersDarkContent ? .darkGray : .lightGray
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: textColor
        ]
        let subTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: subTextColor
        ]
        
        let segmentPercent: Int = {
            let totalValue = values.reduce(0, { $0 + $1.value })
            return Int((segment.value / totalValue) * 100)
        }()
        
        let mainTextRow = NSAttributedString.init(string: segment.title, attributes: textAttributes)
        let subTextRow = NSAttributedString.init(string: "\(segmentPercent) %", attributes: subTextAttributes)
        
        let result = NSMutableAttributedString.init(attributedString: mainTextRow)
        result.append(NSAttributedString(string: "\n"))
        result.append(subTextRow)
        
        return result
    }
    
}

// MARK: - CGFloat extension

private extension CGFloat {
    var radiansToDegrees: CGFloat {
        return self * 180 / .pi
    }
}

// MARK: - CGPoint extension

private extension CGPoint {
    init(center: CGPoint, radius: CGFloat, degrees: CGFloat) {
        self.init(x: cos(degrees) * radius + center.x,
                  y: sin(degrees) * radius + center.y)
    }
    
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(
            x: x + value * cos(angle), y: y + value * sin(angle)
        )
    }
}

// MARK: - CGRect extension

private extension CGRect {
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(
                x: center.x - size.width * 0.5, y: center.y - size.height * 0.5
            ),
            size: size
        )
    }
    var center: CGPoint {
        return CGPoint(x: width / 2 + origin.x,
                       y: height / 2 + origin.y)
    }
}
