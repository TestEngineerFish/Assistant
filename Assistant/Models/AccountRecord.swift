//
//  AccountRecord.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import Foundation
import SwiftData

@Model
class AccountRecord {
    @Attribute(.unique) var id: UUID
    var name: String
    var account: String
    var password: String
    var note: String
    var tags: [Tag] = []

    init(id: UUID = UUID(), name: String = "", account: String = "", password: String = "", note: String = "", tags: [Tag] = []) {
        self.id = id
        self.name = name
        self.account = account
        self.password = password
        self.note = note
        self.tags = tags
    }
}

