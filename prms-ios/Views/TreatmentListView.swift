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
                // list treatments in reverse chronological order
                ForEach(patient.treatments.sorted(by: { treatment1, treatment2 in
                    // Convert dateString to Date objects for comparison
                    let formatter = DateFormatter()
                    formatter.dateFormat = treatment1.dateFormat
                    guard let date1 = formatter.date(from: treatment1.dateString),
                          let date2 = formatter.date(from: treatment2.dateString) else {
                        return false // Handle invalid dates
                    }
                    return date1 > date2 // Sort in descending order
                })) { treatment in
                    NavigationLink(destination: TreatmentView(patient: $patient, treatment: .constant(treatment))) {
                        TreatmentCard(treatment: treatment)
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
