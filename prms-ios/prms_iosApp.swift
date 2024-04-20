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
    @StateObject private var dstore = DoctorsStore()
    @StateObject private var pstore = PatientsStore()

    var body: some Scene {
        WindowGroup {
            LoginView(doctors: $dstore.doctors, patients: $pstore.patients) {
                Task {
                    // Closure for saving patient data
                    do {
                        try await pstore.save(patients: pstore.patients)
                    } catch {
                        fatalError(error.localizedDescription)
                    }

                    // Closure for saving doctor data
                    do {
                        try await dstore.save(doctors: dstore.doctors)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                // Task to load patient data
                do {
                    try await pstore.load()
                } catch {
                    fatalError(error.localizedDescription)
                }

                // Task to load doctor data
                do {
                    try await dstore.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
