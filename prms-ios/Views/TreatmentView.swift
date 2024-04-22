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
    
    var body: some View {
        List {
            Section(header: Text("Health Complaint")) {
                Label("\(treatment.complaint)", systemImage: "exclamationmark.bubble")
                Label("\(patient.name)", systemImage: "person")
            }
            Section(header: Text("Prescription Details")) {
                Label("\(treatment.prescription)", systemImage: "ellipsis.bubble")
                Label("\(treatment.doctor.name)", systemImage: "stethoscope")
                Label("\(treatment.dateString)", systemImage: "calendar")
            }
        }
        .navigationTitle(patient.name)
    }
}


#Preview {
    TreatmentView(patient: .constant(Patient.samplePatients[0]), treatment: .constant(Treatment.sampleTreatments[0]))
}
