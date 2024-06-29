//
//  TreatmentEditView.swift
//  prms
//
//  Created by Aananth C N on 23/06/24.
//

import SwiftUI

struct TreatmentEditView: View {
    @Binding var patient: Patient
    @Binding var treatment: Treatment
    @Binding var isPresentingEditView: Bool

    var body: some View {
        Form {
            Section(header: Text("Patient Details")) {
                HStack {
                    if patient.gender == "Male" {
                        Text("♂").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.gray)
                    } else {
                        Text("♀").font(.title).foregroundColor(.gray)
                    }
                    Text("\(patient.name)").foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "person.badge.clock").foregroundColor(.gray)
                    Text("\(patient.age)").foregroundColor(.gray)
                }
            }
            Section(header: Text("Health Complaint")) {
                HStack {
                    Image(systemName: "exclamationmark.bubble")
                        .foregroundColor(.blue)
                    TextField("Enter the complaint here", text: $treatment.complaint)
                        .frame(minHeight: 50)
                        .onChange(of: treatment.complaint) { oldValue, newValue in
                            updateTreatment()
                        }
                }
            }
            Section(header: Text("Prescription")) {
                HStack {
                    Image(systemName: "ellipsis.bubble")
                        .foregroundColor(.blue)
                    TextField("Prescription by the doctor", text: $treatment.prescription)
                        .frame(minHeight: 50)
                        .onChange(of: treatment.prescription) { oldValue, newValue in
                            updateTreatment()
                        }
                }
            }
            Section(header: Text("Doctor & Date")) {
                HStack {
                    Image(systemName: "stethoscope")
                        .foregroundColor(.blue)
                    TextField("Type the doctor name", text: $treatment.doctor.name)
                        .onChange(of: treatment.doctor.name) { oldValue, newValue in
                            updateTreatment()
                        }
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    TextField("Type the date in YYYY-MM-DD format", text: $treatment.dateString)
                        .onChange(of: treatment.dateString) { oldValue, newValue in
                            updateTreatment()
                        }
                }
            }
        }
        .navigationTitle("Edit Treatment")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    isPresentingEditView = false
                }
            }
        }
    }

    private func updateTreatment() {
        if let index = patient.treatments.firstIndex(where: { $0.id == treatment.id }) {
            patient.treatments[index] = treatment
        }
    }
}

#Preview {
    TreatmentEditView(patient: .constant(Patient.samplePatients[0]), treatment: .constant(Treatment.sampleTreatments[0]), isPresentingEditView: .constant(true))
}
