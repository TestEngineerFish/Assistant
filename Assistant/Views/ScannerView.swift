//
//  ScannerView.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scannerVC = VNDocumentCameraViewController()
        scannerVC.delegate = context.coordinator
        return scannerVC
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            guard let scannedText = processImage(scan.imageOfPage(at: 0)) else { return }
            UIPasteboard.general.string = scannedText
            controller.dismiss(animated: true)
        }
        
        private func processImage(_ image: UIImage) -> String? {
            // 使用 VNRecognizeTextRequest 识别文字
            return "Test"
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
