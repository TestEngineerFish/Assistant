//
//  AccountRecord.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import Foundation

struct AccountRecord: Identifiable {
    var id = UUID()
    var name: String
    var account: String
    var password: String
    var note: String
    var tags: [Tag]
    
    static func emptyRecord() -> AccountRecord {
        return AccountRecord(name: "", account: "", password: "", note: "", tags: [])
    }
}


