//
//  FeedViewModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 28/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class FeedViewModel {
    var dataSource: [FeedCellViewModel]
    
    init() {
        guard let feedProvider: FeedDataProvider = ServiceLocator.shared.getService() else {
            dataSource = []
            return
        }
        dataSource = feedProvider.feedMockData().map({ (feedData) -> FeedCellViewModel in
            return FeedCellViewModel(feedData: feedData)
        })
    }
}
