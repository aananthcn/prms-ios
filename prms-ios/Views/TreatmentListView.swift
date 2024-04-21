//
//  TreatmentListView.swift
//  prms-ios
//
//  Created by Aananth C N on 21/04/24.
//

import SwiftUI

struct TreatmentListView: View {
    @Binding var patient: Patient
    var doctor: Doctor

    @State private var isPresentingTreatAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach ($patient.treatments) { $treatment in
                    NavigationLink(destination: TreatmentView(patient: $patient, treatment: $treatment)) {
                         TreatmentCard(treatment: treatment)
                             .listRowInsets(EdgeInsets(top: 5, leading: 1, bottom: 5, trailing: 1)) // Reduce row insets
                     }
                }
            }
            .navigationTitle(patient.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
                    treatments: $patient.treatments, patient: patient, doctor: doctor,
                    onAddTreatment: { newTreatment in
                        isPresentingTreatAddView = false
                    },
                    onCancel: {
                        // Handle cancel action
                        isPresentingTreatAddView = false
                    }
                )
            }
        }
    }
}


#Preview {
    TreatmentListView(patient: .constant(Patient.samplePatients[0]), doctor: Doctor.sampleDoctors[0])
}
