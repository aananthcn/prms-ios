//
//  prms_iosApp.swift
//  prms-ios
//
//  Created by Aananth C N on 14/04/24.
//

import SwiftUI


@main
struct prms_iosApp: App {
    @State var users = PrmsUsers.sampleUsers

    var body: some Scene {
        WindowGroup {
            MainView(doctors: users)
        }
    }
}

