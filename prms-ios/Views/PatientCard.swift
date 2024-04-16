//
//  PatientView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import SwiftUI

struct PatientCard: View {
    let patient: Patient
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(patient.name)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
                Text(patient.age.codingKey.stringValue)
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

