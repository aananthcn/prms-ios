//
//  PrmsAppMain.swift
//  prms
//
//  Created by Aananth C N on 14/04/24.
//    -- Tamil New Year!
//

import SwiftUI

@main
struct PrmsAppMain: App {
    @StateObject private var dstore = DoctorsStore()
    @StateObject private var pstore = PatientsStore()

    var body: some Scene {
        WindowGroup {
            FirstScreen(doctors: $dstore.doctors, patients: $pstore.patients) {
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
                    // TODO: Handle this error as a info or warning!
                    print(error.localizedDescription)
                }

                // Task to load doctor data
                do {
                    try await dstore.load()
                } catch {
                    // TODO: Handle this error as a info or warning!
                    print(error.localizedDescription)
                }
            }
        }
    }
}
