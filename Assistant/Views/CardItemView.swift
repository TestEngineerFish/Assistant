//
//  CardItemView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI
import Foundation

struct AccountCardView: View {
    var record: AccountRecord
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(record.name)
                    .font(.headline)
                Spacer()
                Text(record.account)
                    .foregroundColor(.gray)
            }
            HStack {
                if isPasswordVisible {
                    Text(record.password)
                } else {
                    SecureField("", text: .constant(record.password))
                }
                Spacer()
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                }
            }
            .contextMenu {
                Button("复制账号", action: { copyToClipBoard(record.account) })
                Button("复制密码", action: { copyToClipBoard(record.password) })
            }
            // 展示 tags
//            FlowLayout(tags: record.tags)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
    
    func copyToClipBoard(_ textToCopy: String) {
#if os(macOS)
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(textToCopy, forType: .string)
#endif
#if os(iOS)
        UIPasteboard.general.string = textToCopy
#endif
      
    }
}
