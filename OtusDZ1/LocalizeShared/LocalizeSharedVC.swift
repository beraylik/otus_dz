//
//  LocalizeSharedVC.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 06/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class LocalizeSharedVC: UIViewController {
    
    // MARK: - Properties
    
    var behaviour: LocalizeSharedBehaviour!
    
    // MARK: - UI Outlets
    
    @IBOutlet weak var mainTextLabel: UILabel!
  
    // MARK: - ViewController Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        behaviour = LocalizeSharedBehaviour()
        behaviour.delegate = self
        addBehaviors(behaviors: [behaviour])
    }
    
    // MARK: - Interactions
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        behaviour.donePressed()
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        behaviour.segmentValueChanged(sender)
    }
  
}

extension LocalizeSharedVC: LocalizerDelegate {
    func updatedText(_ text: String) {
        mainTextLabel.text = text
    }
}
