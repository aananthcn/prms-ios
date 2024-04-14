//
//  PrmsUsers.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import Foundation

struct PrmsUsers: Identifiable, Codable, Hashable {
    let id: UUID
    var doctors: [String]
    
    init(id: UUID = UUID(), doctors: [String]) {
        self.id = id
        self.doctors = doctors
    }
}

// Sample users (outside the struct)
extension PrmsUsers {
    static let sampleUsers: PrmsUsers = PrmsUsers(doctors: ["Dr. Jegadish", "Dr. Rama", "Dr. Arulanandan"])
}
