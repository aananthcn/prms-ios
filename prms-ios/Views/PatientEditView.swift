//
//  PatientEditView.swift
//  prms-ios
//
//  Created by Aananth C N on 17/04/24.
//

import SwiftUI

struct PatientEditView: View {
    @Binding var patient: Patient
    
    var body: some View {
        Form {
            Section(header: Text("Edit Patient Details")) {
                TextField("Patient Name", text: $patient.name)
                Picker("Gender", selection: $patient.gender) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()

                HStack {
                    // Label
                    Text("Year:").font(.caption2)

                    // Convert Int to String when binding to TextField
                    TextField("Birth Year", text: Binding(
                        get: { String(patient.year) }, // Convert Int to String
                        set: { newValue in
                            // Attempt to convert String back to Int
                            if let newYear = Int(newValue) {
                                patient.year = newYear
                            }
                        }
                    ))
                    .keyboardType(.numberPad) // Use numeric keyboard for year input

                    // Label
                    Text("Month [1-12]:").font(.caption2)

                    // Convert Int to String when binding to TextField
                    TextField("Birth Month", text: Binding(
                        get: { String(patient.month) }, // Convert Int to String
                        set: { newValue in
                            // Attempt to convert String back to Int
                            if let newYear = Int(newValue) {
                                patient.year = newYear
                            }
                        }
                    ))
                    .keyboardType(.numberPad) // Use numeric keyboard for year input
                }

                TextField("Phone number", text: $patient.phone)
                    .keyboardType(.numberPad)
                TextField("Email", text: $patient.email)
            }
        } // Form
    }
}



#Preview {
    PatientEditView(patient: .constant(Patient.samplePatients[0]))
}
