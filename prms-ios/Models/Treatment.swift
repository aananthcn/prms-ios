//
//  Treatment.swift
//  prms-ios
//
//  Created by Aananth C N on 21/04/24.
//

import Foundation

struct Treatment: Identifiable, Codable, Hashable {
    let id: UUID
    var complaint: String
    var prescription: String
    var dateString: String
    var dateFormat: String
    var doctor: Doctor
    
    init(id: UUID = UUID(), complaint: String, prescription: String, dateString: String, dateFormat: String, doctor: Doctor) {
        self.id = id
        self.complaint = complaint
        self.prescription = prescription
        self.dateString = dateString
        self.dateFormat = dateFormat
        self.doctor = doctor
    }

    // Sample data for testing
    static let sampleTreatments: [Treatment] = [
        Treatment(complaint: "Stomach Pain", prescription: "Take ginger ale", dateString: "2023-01-01", dateFormat: "yyyy-MM-dd", doctor: Doctor(name: "Dr. Jegadish Baskaran", phone: "90"))
    ]

    // Empty doctor
    static var emptyTreatment: Treatment {
        Treatment(complaint: "", prescription: "", dateString: "", dateFormat: "", doctor: Doctor(name: "", phone: ""))
    }
}
