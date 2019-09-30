//
//  JobScheduler.swift
//  
//
//  Created by Генрих Берайлик on 14/08/2019.
//

import Foundation

class JobScheduler {
    
    var jobs: [JobQueue] = []
    var completion: (([JobQueue]) -> Void)?
    
    func runJobs() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "ru.beraylik.scheduler", qos: .background)
        
        for job in jobs {
            group.enter()
            queue.async {
                job.execute()
                group.leave()
            }
            group.wait()
        }
        completion?(jobs)
    }
    
}
