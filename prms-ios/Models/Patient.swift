//
//  Patients.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import Foundation


struct MonthYear {
    var month: Int
    var year: Int
    
    init(month: Int, year: Int) {
        self.month = month
        self.year = year
    }

    func get_age() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Extract current year and month components
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        // Calculate age based on current date and birthdate
        let birthYear = self.year
        let birthMonth = self.month
        
        // Calculate age by comparing year and month
        var age = currentYear - birthYear
        
        // Check if the birthday hasn't occurred yet this year
        if currentMonth < birthMonth {
            age -= 1
        }
        
        return age
    }
}


struct Patient: Identifiable, Observable {
    var id: UUID
    var name: String
    var phone: String
    var email: String
    var gender: String
    var moye: MonthYear
    var age: Int
    
    init(id: UUID = UUID(), name: String, phone: String, email: String, gender: String, moye: MonthYear) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.gender = gender
        self.moye = moye
        self.age = moye.get_age()
    }

    // sample data for testing
    static let samplePatients: [Patient] = [
        Patient(name: "Donald Trump", phone: "1234567890", email: "trump@example.com", gender: "Male", moye: MonthYear(month: 6, year: 1946)),
        Patient(name: "Angela Merkel", phone: "1234567891", email: "angela@example.com", gender: "Female", moye: MonthYear(month: 7, year: 1954)),
        Patient(name: "Vladimir Putin", phone: "1234567892", email: "putin@example.com", gender: "Male", moye: MonthYear(month: 10, year: 1952)),
        Patient(name: "Xi Jinping", phone: "1234567893", email: "jinping@example.com", gender: "Male", moye: MonthYear(month: 6, year: 1953))
    ]
    
    // empty patient for editing view
    static var emptyPatient: Patient {
        Patient(name: "", phone: "", email: "", gender: "Male", moye: MonthYear(month: 1, year: 1970))
    }
}


