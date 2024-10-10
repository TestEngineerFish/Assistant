//
//  TagView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/10.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    
    var body: some View {
        Text(tag.name)
            .padding(8)
            .background(Color.fromHex(tag.color ?? ""))
            .cornerRadius(10)
    }
}
