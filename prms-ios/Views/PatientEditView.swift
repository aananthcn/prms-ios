//
//  PatientEditView.swift
//  prms-ios
//
//  Created by Aananth C N on 17/04/24.
//

import SwiftUI

struct PatientEditView: View {
    //@Binding var patient: Patient
    @State var patient: Patient

    var body: some View {
        Form {
            Section(header: Text("Edit Patient Details")) {
                TextField("Patient Name", text: $patient.name)
                TextField("Male / Female", text: $patient.gender)
                
                HStack {
                    // Convert Int to String when binding to TextField
                    TextField("Birth Year", text: Binding(
                        get: { String(patient.moye.year) }, // Convert Int to String
                        set: { newValue in
                            // Attempt to convert String back to Int
                            if let newYear = Int(newValue) {
                                patient.moye.year = newYear
                            }
                        }
                    ))
                    .keyboardType(.numberPad) // Use numeric keyboard for year input
                    
                    // Convert Int to String when binding to TextField
                    TextField("Birth Month", text: Binding(
                        get: { String(patient.moye.month) }, // Convert Int to String
                        set: { newValue in
                            // Attempt to convert String back to Int
                            if let newYear = Int(newValue) {
                                patient.moye.year = newYear
                            }
                        }
                    ))
                    .keyboardType(.numberPad) // Use numeric keyboard for year input
                }
                
                TextField("Phone number", text: $patient.phone)
                TextField("Email", text: $patient.email)
            }
        }
    }
}



#Preview {
    PatientEditView(patient: Patient.samplePatients[0])
}
