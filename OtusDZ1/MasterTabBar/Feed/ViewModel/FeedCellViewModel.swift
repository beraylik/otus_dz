//
//  FeedCellViewModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 28/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class FeedCellViewModel {
    private var feedData: FeedData
    
    lazy fileprivate var timeNumberFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let digits = 6
        formatter.minimumFractionDigits = digits
        formatter.maximumFractionDigits = digits
        return formatter
    }()
    
    var name: String {
        return feedData.name
    }
    
    var subtitle: String? {
        if let interval = testResult, let readable = formattedTime(interval) {
            return "\(readable) sec"
        } else {
            return nil
        }
    }
    
    var testResult: TimeInterval?
    
    init(feedData: FeedData) {
        self.feedData = feedData
    }
    
    func formattedTime(_ time: TimeInterval) -> String? {
        return timeNumberFormatter.string(from: time as NSNumber)
    }
}
