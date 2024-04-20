//
//  DoctorsView.swift
//  prms-ios
//
//  Created by Aananth C N on 19/04/24.
//

import SwiftUI


struct DoctorListView: View {
    @Binding var isPresentingDoctorsView: Bool
    @Binding var currDoctorIndex: Int
    @Binding var doctors: [Doctor]
    
    var body: some View {
        NavigationView {
            List {
                ForEach ($doctors) { $doctor in
                    NavigationLink(destination: DoctorView(doctor: $doctor, currDoctorIndex: $currDoctorIndex, doctors: $doctors)) {
                        Label(doctor.name, systemImage: "person")
                    }
                }
            }
            .navigationTitle("Doctors")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        isPresentingDoctorsView = false
                    }
                }
            }
        }
    }
}



#Preview {
    DoctorListView(isPresentingDoctorsView: .constant(true), currDoctorIndex: .constant(0), doctors: .constant(Doctor.sampleDoctors))
}
