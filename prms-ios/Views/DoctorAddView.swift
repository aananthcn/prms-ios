//
//  DoctorAddView.swift
//  prms-ios
//
//  Created by Aananth C N on 20/04/24.
//

import SwiftUI

struct DoctorAddView: View {
    @Binding var doctors: [Doctor]
    @State private var doctor = Doctor.emptyDoctor

    var onAddDoctor: (Doctor) -> Void // Closure to handle add button
    var onCancel: () -> Void  // Closure to handle cancel action

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Doctor Details")) {
                    TextField("Doctor Name", text: $doctor.name)
                    TextField("Phone Number", text: $doctor.phone)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("New Doctor")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Call the cancel closure when the cancel button is tapped
                        onCancel()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        doctors.append(doctor)
                        onAddDoctor(doctor)
                    }
                }
            }
        }
    }
}


#Preview {
    DoctorAddView(doctors: .constant(Doctor.sampleDoctors), onAddDoctor: {_ in }, onCancel: {})
}
