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
    var phone: String
    
    init(id: UUID = UUID(), name: String, phone: String) {
        self.id = id
        self.name = name
        self.phone = phone
    }

    // Sample data for testing
    static let sampleDoctors: [Doctor] = [
        Doctor(name: "Dr. Jegadish", phone: ""),
        Doctor(name: "Dr. Rama", phone: ""),
        Doctor(name: "Dr. Sachidanandan", phone: ""),
        Doctor(name: "Dr. Arulanandan", phone: "")
    ]

    // Empty doctor
    static var emptyDoctor: Doctor {
        Doctor(name: "", phone: "")
    }
}
