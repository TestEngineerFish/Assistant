//
//  Tag.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    var color: String?
    init(id: UUID = UUID(), name: String, color: Color) {
        self.id = id
        self.name = name
        self.color = color.toHex()
    }
}
