//
//  Item.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
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
