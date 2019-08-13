//
//  SuffixSequenceViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

private enum SequenceVCRow: Int {
    case lookupRandom10 = 0,
    lookupCustomTimes
}

class SuffixSequenceViewController: DataStructuresViewController {
    
    //MARK: - Variables
    
    let sequenceManipulator: SequenceManipulator = {
        if let service: AlgoProvider = ServiceLocator.shared.getService() {
            return SwiftSequenceManipulator(service: service)
        }else {
            let algo = AlgoProvider()
            return SwiftSequenceManipulator(service: algo)
        }
        
    
    }()
    
    var lookupRandom10Time: TimeInterval = 0
    var lookupCustomTimesTime: TimeInterval = 0
    
    //MARK: - Methods
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAndTestButton.setTitle("Create Sequence and Test", for: [])
    }
    
    //MARK: Superclass creation/testing overrides
    
    override func create(_ size: Int) {
        sequenceManipulator.setCustomTimes(size)
    }
    
    override func test() {
        if (sequenceManipulator.arrayHasObjects()) {
            lookupRandom10Time = sequenceManipulator.lookup10times()
            lookupCustomTimesTime = sequenceManipulator.lookupCustomTimes()
        } else {
            print("Sequence not set up yet!")
        }
    }
    
    //MARK: Table View Override
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        switch (indexPath as NSIndexPath).row {
        case SequenceVCRow.lookupRandom10.rawValue:
            cell.textLabel!.text = "Lookup 10 random substrings:"
            cell.detailTextLabel!.text = formattedTime(lookupRandom10Time)
        case SequenceVCRow.lookupCustomTimes.rawValue:
            cell.textLabel!.text = "Lookup preffered times:"
            cell.detailTextLabel!.text = formattedTime(lookupCustomTimesTime)
        default:
            print("Unhandled row! \((indexPath as NSIndexPath).row)")
        }
        
        return cell
    }
    
    // MARK: - TableView number of rows override
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
