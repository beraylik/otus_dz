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
    
    var name: String {
        return feedData.name
    }
    
    init(feedData: FeedData) {
        self.feedData = feedData
    }
}
