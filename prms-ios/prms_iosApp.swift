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
    @StateObject private var pat_store = PatientStore()

    var body: some Scene {
        WindowGroup {
            MainView(doctors: users, patients: $pat_store.patients)
                .task {
                       do {
                           try await pat_store.load()
                       } catch {
                           fatalError(error.localizedDescription)
                       }
                   }
        }
    }
}

