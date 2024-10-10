//
//  ToastView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/10.
//

import Foundation
import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(8)
            .padding(.bottom, 50) // 调整弹出位置
            .transition(.opacity) // 添加淡入淡出动画
            .zIndex(1) // 确保 Toast 显示在最前面
    }
}
