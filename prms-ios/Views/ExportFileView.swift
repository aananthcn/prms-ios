//
//  ShareFileView.swift
//  prms-ios
//
//  Created by Aananth C N on 27/04/24.
//

import SwiftUI


struct ExportFileView: UIViewControllerRepresentable {
    let url: URL
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            // Dismiss the view when sharing is completed or canceled
            self.isPresented = false
        }
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}

    typealias UIViewControllerType = UIActivityViewController
}

