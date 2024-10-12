//
//  TagView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/10.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    var isSelected: Bool
    
    var body: some View {
        Text(verbatim: tag.name)
            .padding(5)
            .frame(maxWidth: 150)
            .overlay {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(.gray, lineWidth: 1)
            }
            .background(isSelected ? Color.red : Color.clear)
            .lineLimit(1)
    }
}
