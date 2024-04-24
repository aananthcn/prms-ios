//
//  PatientView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import SwiftUI

struct PatientCard: View {
    let patient: Patient

    // Computed property to calculate age dynamically based on the current date
    var dynamicAge: Int {
        let currentDate = Date()
        let calendar = Calendar.current

        // Extract birth year and month components from patient's information
        let birthYear = patient.year
        let birthMonth = patient.month

        // Extract current year and month components
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)

        // Calculate age based on current date and patient's birthdate
        var age = currentYear - birthYear

        // Adjust age if current month is before patient's birth month in the current year
        if currentMonth < birthMonth {
            age -= 1
        }

        return age
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(patient.name)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
                Text("\(dynamicAge)")
            }
            HStack {
                Label("\(patient.phone)", systemImage: "phone")
                Spacer()
                if patient.gender == "Male" {
                    Text("♂").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                } else {
                    Text("♀").font(.title)
                }
            }
        } // VStack
        .padding(.horizontal, 0.1)
    }
}



#Preview {
    PatientCard(patient: Patient.samplePatients[0])
        .previewLayout(.fixed(width: 400, height: 60))
}

