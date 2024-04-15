//
//  PatientView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import SwiftUI

struct PatientView: View {
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
            Spacer()
            HStack {
                Label("\(patient.phone)", systemImage: "phone")
                Spacer()
                //Label("\(patient.gender)", systemImage: "male")
                if patient.gender == "Male" {
                    Text("♂").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                } else {
                    Text("♀").font(.title)
                }
            }
        } // VStack
        .padding()
        .background(Color(red: 0.9, green: 0.95, blue: 0))
    }
}



#Preview {
    PatientView(patient: Patient.samplePatient)
        .previewLayout(.fixed(width: 400, height: 60))
}

