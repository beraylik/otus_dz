//
//  UITableView+Extensions.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 19/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var cellId: String {
        return self.description()
    }
    
}
