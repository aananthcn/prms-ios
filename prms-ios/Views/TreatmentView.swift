//
//  Treatment.swift
//  prms-ios
//
//  Created by Aananth C N on 21/04/24.
//

import SwiftUI

struct TreatmentView: View {
    @Binding var patient: Patient
    @Binding var treatment: Treatment
    
    @State private var isPresentingEditView = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Patient Details")) {
                    HStack {
                        if patient.gender == "Male" {
                            Text("♂").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        } else {
                            Text("♀").font(.title).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        Text("\(patient.name)")
                    }
                    HStack {
                        Image(systemName: "person.badge.clock").foregroundColor(.blue)
                        Text("\(patient.age)")
                    }
                }
                Section(header: Text("Health Complaint")) {
                    Label("\(treatment.complaint)", systemImage: "exclamationmark.bubble")
                }
                Section(header: Text("Prescription Details")) {
                    Label("\(treatment.prescription)", systemImage: "ellipsis.bubble")
                }
                Section(header: Text("Doctor & Date")) {
                    Label("\(treatment.dateString)", systemImage: "calendar")
                    Label("\(treatment.doctor.name)", systemImage: "stethoscope")
                }
            }
            .navigationTitle("Treatment")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                    .accessibilityLabel("Edit Treatment")
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationStack {
                    TreatmentEditView(patient: $patient, treatment: $treatment, isPresentingEditView: $isPresentingEditView)
                }
            }
        }
    }
}

#Preview {
    TreatmentView(patient: .constant(Patient.samplePatients[0]), treatment: .constant(Treatment.sampleTreatments[0]))
}
