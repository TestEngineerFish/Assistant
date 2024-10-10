//
//  HomeView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI
import SwiftData

struct NewContentView: View {
    @Query private var accountRecords: [AccountRecord] // 账号记录列表
    @State private var showingScanner = false
    @State private var showingAddRecord = false
    
    var body: some View {
        NavigationView {
            VStack {
                if accountRecords.isEmpty {
                    Text("暂无账号记录")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        ForEach(accountRecords) { record in
                            AccountCardView(record: record)
                                .padding(.vertical, 5)
                                .onTapGesture {
                                    // 跳转到编辑页面
                                    showingAddRecord = true
                                }
                        }
                    }
                }
            }
            .navigationTitle("账号管理")
#if os(iOS)
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    showingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                }
                .sheet(isPresented: $showingScanner) {
                    ScannerView() // 扫码页面
                }
                NavigationLink(destination: AddRecordView(isEditing: false, record: AccountRecord())) {
                    Image(systemName: "plus")
                }
            })
#endif
        }
    }
}


#Preview {
    NewContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
