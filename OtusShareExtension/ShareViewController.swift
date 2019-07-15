//
//  ShareViewController.swift
//  OtusShareExtension
//
//  Created by Генрих Берайлик on 06/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        guard let text = textView.text else {return}
        guard let sharedDefaults = UserDefaults(suiteName: "group.beraylik.share") else { return }
        sharedDefaults.set(text, forKey: "LocalizeText")
        
        if let url = URL(string: "OtusDzUrl://LocalizeSharedVC") {
            _ = openURL(url)
        }
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }
    
}
