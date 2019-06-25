//
//  Services.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 06/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class Services {
    
    static var diagramImageProvider: DiagramImageProvider = {
        return DiagramImageProvider()
    }()
    
    static var algoProvider: AlgoProvider = {
        return AlgoProvider()
    }()
    
    static var jsonProvider: JsonPlaceholderProvider = {
        return JsonPlaceholderProvider()
    }()
}
