//
//  DoctorEditView.swift
//  prms
//
//  Created by Aananth C N on 19/04/24.
//

import SwiftUI


struct DoctorEditView: View {
    @Binding var doctor: Doctor

    var body: some View {
        Form {
            Section(header: Text("Edit Doctor Details")) {
                TextField("Doctor Name", text: $doctor.name)
                TextField("Phone Number", text: $doctor.phone)
                    .keyboardType(.numberPad)
            }
        }
    }
}



#Preview {
    DoctorEditView(doctor: .constant(Doctor.sampleDoctors[0]))
}
