//
//  DiagramImageProvider.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 06/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

final class DiagramImageProvider {
    
    func random() -> UIImage? {
        let index = Int.random(in: 1..<4)
        
        return UIImage(named: "diagram-\(index)")
    }
    
}
