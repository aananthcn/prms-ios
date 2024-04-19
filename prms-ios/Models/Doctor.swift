//
//  PrmsUsers.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import Foundation

struct Doctor: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }

    // Sample data for testing
    static let sampleDoctors: [Doctor] = [
        Doctor(name: "Dr. Jegadish"),
        Doctor(name: "Dr. Rama"),
        Doctor(name: "Dr. Sachidanandan"),
        Doctor(name: "Dr. Arulanandan")
    ]
}
