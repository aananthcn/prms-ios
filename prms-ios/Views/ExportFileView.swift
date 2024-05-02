//
//  ExportFileView.swift
//  prms-ios
//
//  Created by Aananth C N on 27/04/24.
//

import SwiftUI


struct ExportFileView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var patients: [Patient]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        // Create a temporary file URL to store patient data
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("patients.data")

        do {
            // Encode patients array to JSON data
            let jsonData = try JSONEncoder().encode(patients)
            // Write JSON data to temporary file
            try jsonData.write(to: tempURL)
        } catch {
            // Handle error while encoding or writing data
            fatalError("Error occurred while encoding or writing patient data: \(error)")
        }

        // Create UIActivityViewController with the temporary file URL
        let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            // Dismiss the view when sharing is completed or canceled
            self.isPresented = false
            // Remove temporary file after sharing
            do {
                try FileManager.default.removeItem(at: tempURL)
            } catch {
                // Handle error while deleting temporary file
                print("Error occurred while deleting temporary file: \(error)")
            }
        }
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

