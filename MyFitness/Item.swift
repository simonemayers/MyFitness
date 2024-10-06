//
//  Item.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
