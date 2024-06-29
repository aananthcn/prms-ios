//
//  Doctorview.swift
//  prms
//
//  Created by Aananth C N on 19/04/24.
//

import SwiftUI

struct DoctorView: View {
    @Binding var doctor: Doctor
    @Binding var currDoctorIndex: Int
    @Binding var doctors: [Doctor]

    @State private var isPresentingEditView = false
    @State private var isShowingDeleteAlert = false
    

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
            Button(action:{
                isShowingDeleteAlert = true
            }){
                Image(systemName: "xmark.bin.circle")
            }
            .accessibilityLabel("New Doctor")
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
        .alert(isPresented: $isShowingDeleteAlert) {
            var retval: Alert
            
            if doctors[currDoctorIndex].id != doctor.id {
                retval = Alert(
                    title: Text("Delete Doctor"),
                    message: Text("Are you sure you want to delete \(doctor.name)?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteDoctor()
                    },
                    secondaryButton: .cancel()
                )
            } else {
                retval = Alert(
                    title: Text("Cannot Delete"),
                    message: Text("You cannot delete the currently logged-in doctor."),
                    dismissButton: .default(Text("OK")) {
                        // Optionally handle dismiss action
                    }
                )
            }
            
            return retval
        }
    }

    private func deleteDoctor() {
        let currDoctor = doctors[currDoctorIndex]
        
        if currDoctor.id != doctor.id {
            doctors.removeAll { $0.id == doctor.id }
            
            // re-compute the index
            currDoctorIndex = doctors.firstIndex(of: currDoctor) ?? 0
        }
        
    }
}


#Preview {
    DoctorView(doctor: .constant(Doctor.sampleDoctors[0]), currDoctorIndex: .constant(0), doctors: .constant( Doctor.sampleDoctors))
}
