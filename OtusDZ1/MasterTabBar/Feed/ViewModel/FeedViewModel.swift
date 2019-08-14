//
//  FeedViewModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 28/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

final class FeedViewModel {
    
    var dataSource: [FeedCellViewModel]
    
    private let feedProvider: FeedDataProvider
    
    init(feedProvider: FeedDataProvider) {
        self.feedProvider = feedProvider
        dataSource = feedProvider.feedMockData().map({ (feedData) -> FeedCellViewModel in
            return FeedCellViewModel(feedData: feedData)
        })
    }
}
