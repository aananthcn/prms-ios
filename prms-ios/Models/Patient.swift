//
//  Patients.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import Foundation

struct Patient: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var phone: String
    var email: String
    var address: String
    var gender: String
    var month: Int
    var year: Int
    var age: Int  // Property to hold calculated age
    var treatments: [Treatment]

    init(id: UUID = UUID(), name: String, phone: String, email: String, gender: String, year: Int, month: Int, treatments: [Treatment] = []) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.address = ""
        self.gender = gender
        self.month = month
        self.year = year
        self.age = Patient.calculateAge(year: year, month: month)  // Calculate age
        self.treatments = treatments
    }

    // Calculate age based on birth year and month
    static func calculateAge(year: Int, month: Int) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current

        // Extract current year and month components
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)

        // Calculate age based on current date and birthdate
        var age = currentYear - year

        // Check if the birthday hasn't occurred yet this year
        if currentMonth < month {
            age -= 1
        }

        return age
    }

    // Sample data for testing
    static let samplePatients: [Patient] = [
        Patient(name: "Donald Trump", phone: "1234567890", email: "trump@example.com", gender: "Male", year: 1946, month: 6),
        Patient(name: "Angela Merkel", phone: "1234567891", email: "angela@example.com", gender: "Female", year: 1954, month: 7),
        Patient(name: "Vladimir Putin", phone: "1234567892", email: "putin@example.com", gender: "Male", year: 1952, month: 10),
        Patient(name: "Xi Jinping", phone: "1234567893", email: "jinping@example.com", gender: "Male", year: 1953, month: 6)
    ]

    // Empty patient for editing view
    static var emptyPatient: Patient {
        Patient(name: "", phone: "", email: "", gender: "Male", year: 1970, month: 1)
    }
}

extension Patient {
    mutating func updateDetails(from importedPatient: Patient) {
        // Update other details of the existing patient from the imported patient
        self.address = importedPatient.address
        self.email = importedPatient.email
        self.gender = importedPatient.gender
        self.year = importedPatient.year
        self.month = importedPatient.month
        self.id = importedPatient.id
    }
}
