//
//  EditView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI

struct AddRecordView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var isEditing: Bool // 区分添加和编辑状态
    @State var record: AccountRecord // 记录模型
    @State private var selectedColor = Color.blue
    @State private var tags: [Tag] = []
    @State private var showToast = false
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case name, account, password, remark
    }
    
    var body: some View {
        
        ZStack {
            Form {
                Section(header: Text("账号信息")) {
                    TextField("名称", text: $record.name)
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .account
                        }
                    TextField("账号", text: $record.account)
                        .focused($focusedField, equals: .account)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .password
                        }
                    TextField("密码", text: $record.password)
                        .textContentType(.password)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .remark
                        }
                }
                Text(verbatim: "备注")
                TextEditor(text: $record.note)
                    .frame(height: 200)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .remark)
                
                Section(header: Text("标签")) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(record.tags, id: \.self) { tag in
                                Text(tag.name)
                            }
                        }
                    }
                    AddTagView(tags: $record.tags)
                }
                if showToast {
                    ToastView(message: "操作成功")
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showToast = false
                                dismiss()
                            }
                        }
                }
            }.onAppear {
                focusedField = .name
            }
#if os(iOS)
            .navigationBarTitle(isEditing ? "编辑记录" : "添加记录", displayMode: .inline)
            .navigationBarItems(trailing: Button("保存") {
                saveRecord()
            })
            .toolbar {
                if isEditing {
                    ToolbarItem(placement: .bottomBar) {
                        Button("删除") {
                            deleteRecord()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
#elseif os(macOS)
            .navigationTitle(isEditing ? "编辑记录" : "添加记录") // 使用macOS支持的导航标题
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("保存") {
                        saveRecord()
                    }
                }
                if isEditing {
                    ToolbarItem(placement: .automatic) {
                        Button("删除") {
                            deleteRecord()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
#endif
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // 保存记录
    private func saveRecord() {
        modelContext.insert(record)
        try? modelContext.save() // 保存到持久化存储
        showToast = true
    }
    
    // 删除记录
    private func deleteRecord() {
        modelContext.delete(record)
        try? modelContext.save() // 保存更改
        showToast = true
    }
}
