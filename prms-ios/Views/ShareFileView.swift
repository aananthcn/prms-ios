//
//  ShareFileView.swift
//  prms-ios
//
//  Created by Aananth C N on 27/04/24.
//

import SwiftUI
import UIKit

struct ShareFileView: UIViewControllerRepresentable {
    let url: URL
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)? // Closure to handle dismissal

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let interactionController = UIDocumentInteractionController(url: url)
        interactionController.delegate = context.coordinator
        interactionController.presentOptionsMenu(from: controller.view.bounds, in: controller.view, animated: true)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIDocumentInteractionControllerDelegate {
        let parent: ShareFileView

        init(parent: ShareFileView) {
            self.parent = parent
        }

        func documentInteractionControllerDidDismissOptionsMenu(_ controller: UIDocumentInteractionController) {
            parent.isPresented = false // Update binding to dismiss the view
            parent.onDismiss?() // Call the dismissal closure if provided
        }
    }
}




#Preview(body: {
    ShareFileView(url:URL(string: "https://example.com/dummy")!, isPresented: .constant(false))
})
