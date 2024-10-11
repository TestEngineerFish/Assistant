//
//  TagView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI

struct AddTagView: View {
    @Binding var tags: [Tag]
    @State private var newTagName = ""
    @State private var selectedColor = Color.red
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
//            ColorPicker("选择颜色", selection: $selectedColor)
            Button("添加标签") {
                showingAlert = true
            }
            .sheet(isPresented: $showingAlert, content: {
                TextField("标签名称", text: $newTagName)
                ColorPicker("选择颜色", selection: $selectedColor)
                Button("确定", action: addTag)
                Button("取消", role: .cancel, action: {})
            })
        }
    }
    
    func addTag() {
        if !newTagName.isEmpty {
            let newTag = Tag(name: newTagName, color: selectedColor)
            tags.append(newTag)
            newTagName = ""
        }
    }
}
