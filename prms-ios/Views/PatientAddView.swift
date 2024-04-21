//
//  PatientAddView.swift
//  prms-ios
//
//  Created by Aananth C N on 20/04/24.
//

import SwiftUI

struct PatientAddView: View {
    @Binding var patients: [Patient]
    @State private var patient = Patient.emptyPatient

    var onAddPatient: (Patient) -> Void // Closure to handle add button
    var onCancel: () -> Void  // Closure to handle cancel action

    var body: some View {
        NavigationView {
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
                                if let newMonth = Int(newValue) {
                                    patient.month = newMonth
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
            .navigationTitle("New Patient")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Call the cancel closure when the cancel button is tapped
                        onCancel()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        patients.append(patient)
                        onAddPatient(patient)
                    }
                }
            }
        }
    }
}


#Preview {
    PatientAddView(patients: .constant(Patient.samplePatients), onAddPatient: {_ in }, onCancel: {})
}
