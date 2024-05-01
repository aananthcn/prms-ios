//
//  ImportFileView.swift
//  prms-ios
//
//  Created by Aananth C N on 01/05/24.
//

import SwiftUI
import UIKit


struct ImportFileView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var onImport: ((URL) -> Void)? // Closure to handle imported file URL

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let viewController = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: ImportFileView

        init(parent: ImportFileView) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.onImport?(url)
            }
            parent.isPresented = false // Dismiss the picker
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.isPresented = false // Dismiss the picker if cancelled
        }
    }
}
