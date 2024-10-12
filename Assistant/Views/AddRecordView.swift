//
//  EditView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI
import SwiftData


struct AddRecordView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var tags: [Tag]
    @State var isEditing: Bool // 区分添加和编辑状态
    @State var record: AccountRecord // 记录模型
    @State var tmpTags: [Tag] = []
    @State private var selectedColor = Color.blue
    @State private var showToast = false
    @State private var newTagName: String = ""
    @FocusState private var focusedField: Field?
    private let cellHeight: CGFloat = 50
    
    enum Field: Hashable {
        case name, account, password, remark
    }
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("账号信息")) {
                    TextField("名称", text: $record.name)
                        .frame(height: cellHeight)
                    TextField("账号", text: $record.account)
                        .frame(height: cellHeight)
                    TextField("密码", text: $record.password)
                        .frame(height: cellHeight)
                        .textContentType(.password)
                }
                Text(verbatim: "备注")
                TextEditor(text: $record.note)
                    .frame(height: 100)
                    .submitLabel(.done)
                
                Section(header: Text("标签")) {
                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(tmpTags) { tag in
                                    TagView(tag: tag, isSelected: true)
                                }
                            }
                        }.padding()
                        TextField("新增标签", text: $newTagName)
                            .frame(width: 100)
                            .onSubmit {
                                saveTag()
                            }
                    }
                    
                    let coloums = [GridItem(.adaptive(minimum: 80), spacing: 10)]
                    LazyVGrid(columns: coloums, alignment: .leading, spacing: 15) {
                        ForEach(tags, id: \.id) { tag in
                            TagView(tag: tag, isSelected: record.tags.contains(tag) || tmpTags.contains(tag))
                                .onTapGesture {
                                    tmpTags.append(tag)
                                }
                        }
                    }
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
            hideKeyboard()
        }
        .onAppear {
            self.tmpTags = record.tags
            UITextField.appearance().inputAssistantItem.leadingBarButtonGroups = []
            UITextField.appearance().inputAssistantItem.trailingBarButtonGroups = []
        }
    }
    
    func hideKeyboard() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.endEditing(true)
        }
    }
    
    // 保存Tag
    private func saveTag() {
        let tag = Tag(name: newTagName, color: .red)
        modelContext.insert(tag)
        try? modelContext.save() // 保存到持久化存储
        self.tmpTags.append(tag)
        newTagName = ""
    }
    
    // 保存记录
    private func saveRecord() {
        record.tags = tmpTags
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


