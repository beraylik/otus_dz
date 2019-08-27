//
//  FeedViewModel.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 28/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation
import TestProfiler

final class FeedViewModel {
    
    var dataSource: [FeedCellViewModel]
    var testsCompletion: (() -> Void)?
    
    private let feedProvider: FeedDataProvider
    
    init(feedProvider: FeedDataProvider) {
        self.feedProvider = feedProvider
        dataSource = feedProvider.feedMockData().map({ (feedData) -> FeedCellViewModel in
            return FeedCellViewModel(feedData: feedData)
        })
    }
    
    func runTests() {
        let intensity = 10000
        print("Will run creation tests with \(intensity) items")
        // Running tests
        let arrayJob = JobQueue()
        arrayJob.task = {
            let profiler = SwiftArrayManipulator()
            return profiler.setupWithObjectCount(intensity)
        }
        
        let dictJob = JobQueue()
        dictJob.task = {
            let profiler = SwiftDictionaryManipulator()
            return profiler.setupWithEntryCount(intensity)
        }
        
        let setJob = JobQueue()
        setJob.task = {
            let profiler = SwiftSetManipulator()
            return profiler.setupWithObjectCount(intensity)
        }
        
        let sequenceJob = JobQueue()
        sequenceJob.task = {
            let algoProvider: AlgoProvider = ServiceLocator.shared.getService() ?? AlgoProvider()
            let profiler = SwiftSequenceManipulator(service: algoProvider)
            profiler.setCustomTimes(intensity)
            return profiler.lookupCustomTimes()
        }
        
        let scheduler = JobScheduler()
        scheduler.jobs = [arrayJob, dictJob, setJob]
        scheduler.completion = { [weak self] jobs in
            guard let strongSelf = self else { return }
            guard strongSelf.dataSource.count >= 3 && jobs.count >= 3 else { return }
            for index in 0..<3 {
                strongSelf.dataSource[index].testResult = jobs[index].executionTime
            }
            strongSelf.testsCompletion?()
        }
        scheduler.runJobs()
    }
}
