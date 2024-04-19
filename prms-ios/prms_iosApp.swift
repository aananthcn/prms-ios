//
//  prms_iosApp.swift
//  prms-ios
//
//  Created by Aananth C N on 14/04/24.
//    -- Tamil New Year!
//

import SwiftUI

@main
struct prms_iosApp: App {
    @State var users = PrmsUsers.sampleUsers
    @StateObject private var store = PrmsStore()

    var body: some Scene {
        WindowGroup {
            MainView(doctors: users, patients: $store.patients) {
                Task {
                    // Closure for saving data
                    do {
                        try await store.save(patients: store.patients)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                // Task to load data
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
