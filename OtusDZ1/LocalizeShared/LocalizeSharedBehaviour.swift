//
//  LocalizeSharedBehaviour.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 06/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

protocol LocalizerDelegate: class {
    func updatedText(_ text: String)
}

final class LocalizeSharedBehaviour: ViewControllerLifecycleBehavior {
    
    var delegate: LocalizerDelegate?
    
    // MARK: Behaviour life cycle
    
    func afterLoading(_ viewController: UIViewController) {
        guard let sharedText = loadSharedText() else { return }
        print(sharedText)
        
        // Default is Russia
        let localizer = TextLocalizer(localeCode: "ru")
        let text = localizer.localizeText(sharedText)
        delegate?.updatedText(text)
    }
    
    /// loading message from Extension
    private func loadSharedText() -> String? {
        guard
            let sharedUserDefaults = UserDefaults.init(suiteName: "group.beraylik.share"),
            let text = sharedUserDefaults.value(forKey: "LocalizeText") as? String
        else {
            return nil
        }
        return text
    }
    
    // MARK: - Interactions
    
    func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let sharedText = loadSharedText() else { return }
        let localizer: TextLocalizer!
        
        switch sender.selectedSegmentIndex {
        case 0: // Russia
            localizer = TextLocalizer(localeCode: "ru")
        case 1: // USA
            localizer = TextLocalizer(localeCode: "en_US")
        case 2: // France
            localizer = TextLocalizer(localeCode: "fr")
        case 3: // Japan
            localizer = TextLocalizer(localeCode: "jp")
        case 4: // China
            localizer = TextLocalizer(localeCode: "zh")
        default:
            return
        }
        
        let text = localizer.localizeText(sharedText)
        delegate?.updatedText(text)
    }
 
    func donePressed() {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "master") as UIViewController
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = initialViewController
    }
    
}
