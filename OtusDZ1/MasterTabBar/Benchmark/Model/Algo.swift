//
//  Algo.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class Algo: Codable {
    var name: String
    var intervalOn: TimeInterval = 0
    var intervalOff: TimeInterval = 1
    var color: UIColor
    
    init(name: String) {
        self.name = name
        self.color = UIColor.random
    }
    
    func suffixed() -> SuffixSequence {
        return SuffixSequence(string: name)
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case name, intervalOn, intervalOff, color
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(intervalOn, forKey: .intervalOn)
        try container.encode(intervalOff, forKey: .intervalOff)
        try container.encode(color.toHex, forKey: .color)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.intervalOn = try container.decode(TimeInterval.self, forKey: .intervalOn)
        self.intervalOff = try container.decode(TimeInterval.self, forKey: .intervalOff)
        
        let hex = try container.decode(String.self, forKey: .color)
        self.color = UIColor.init(hex: hex) ?? .white
    }
}
