//
//  EditView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI

struct AddRecordView: View {
    @State var isEditing: Bool // 区分添加和编辑状态
    @State var record: AccountRecord // 记录模型
    @State private var newTag = ""
    @State private var selectedColor = Color.blue
    
    var body: some View {
        Form {
            Section(header: Text("账号信息")) {
                TextField("名称", text: $record.name)
                TextField("账号", text: $record.account)
                TextField("密码", text: $record.password)
                    .textContentType(.password)
                TextField("备注", text: $record.note)
            }
            
            Section(header: Text("标签")) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(record.tags, id: \.self) { tag in
                            TagView(tag: tag)
                        }
                    }
                }
                Button(action: {
                    // 弹出添加tag弹框
                }) {
                    Text("添加标签")
                }
            }
        }
        .navigationBarTitle(isEditing ? "编辑记录" : "添加记录", displayMode: .inline)
        .navigationBarItems(trailing: Button("保存") {
            // 保存数据到数据库
        })
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .bottomBar) {
                    Button("删除") {
                        // 删除操作
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}
