//
//  Doctorview.swift
//  prms-ios
//
//  Created by Aananth C N on 19/04/24.
//

import SwiftUI

struct DoctorView: View {
    @Binding var doctor: Doctor
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Doctor Info")) {
                Label("\(doctor.name)", systemImage: "person")
                Label("\(doctor.phone)", systemImage: "phone")
            }
        }
        .navigationTitle(doctor.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DoctorEditView(doctor: $doctor)
                    .navigationTitle($doctor.name)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}


#Preview {
    DoctorView(doctor: .constant(Doctor.sampleDoctors[0]))
}
