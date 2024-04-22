//
//  TreatmentListView.swift
//  prms-ios
//
//  Created by Aananth C N on 21/04/24.
//

import SwiftUI

struct TreatmentListView: View {
    @Binding var patient: Patient
    @Binding var patients: [Patient]
    var doctor: Doctor

    @State private var isPresentingTreatAddView = false
    @State private var isPresentingPatientView = false

    var body: some View {
        NavigationView {
            List {
                ForEach($patient.treatments) { $treatment in
                    NavigationLink(destination: TreatmentView(patient: $patient, treatment: $treatment)) {
                        TreatmentCard(treatment: treatment)
                            .listRowInsets(EdgeInsets(top: 5, leading: 1, bottom: 5, trailing: 1))
                    }
                }
            }
            .navigationTitle(patient.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: PatientView(patient: $patient, patients: $patients)) {
                        Image(systemName: "person")
                            .accessibilityLabel("Patient View")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingTreatAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Treatment")
                }
            }
            .sheet(isPresented: $isPresentingTreatAddView) {
                TreatmentAddView(
                    treatments: $patient.treatments,
                    patient: patient,
                    doctor: doctor,
                    onAddTreatment: { newTreatment in
                        isPresentingTreatAddView = false
                    },
                    onCancel: {
                        isPresentingTreatAddView = false
                    }
                )
            }
        }
    }
}


#Preview {
    TreatmentListView(patient: .constant(Patient.samplePatients[0]), patients: .constant(Patient.samplePatients), doctor: Doctor.sampleDoctors[0])
}
