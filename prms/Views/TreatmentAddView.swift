//
//  TreatmentAddView.swift
//  prms
//
//  Created by Aananth C N on 21/04/24.
//

import SwiftUI

struct TreatmentAddView: View {
    @Binding var treatments: [Treatment]
    var patient: Patient
    var doctor: Doctor
    
    @State private var editedTreatment: Treatment

    var onAddTreatment: (Treatment) -> Void // Closure to handle add button
    var onCancel: () -> Void  // Closure to handle cancel action

    init(treatments: Binding<[Treatment]>, patient: Patient, doctor: Doctor, onAddTreatment: @escaping (Treatment) -> Void, onCancel: @escaping () -> Void) {
        self._treatments = treatments
        self.patient = patient
        self.doctor = doctor
        self._editedTreatment = State(initialValue: Treatment.emptyTreatment)
        self.onAddTreatment = onAddTreatment
        self.onCancel = onCancel
    }

    var body: some View {
        NavigationView {
            Form {
                Section("For Whom?") {
                    HStack {
                        Label("\(patient.name)", systemImage: "person")
                        Spacer()
                        Text("Age: \(patient.age)")
                    }
                }
                Section(header: Text("Health Complaint")) {
                    TextField("Enter the complaint here.", text: $editedTreatment.complaint)
                        .frame(minHeight: 50)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Section(header: Text("Prescription Details")) {
                    TextField("Enter the prescription.", text: $editedTreatment.prescription)
                        .frame(minHeight: 50)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Section(header: Text("Doctor & Date")) {
                    Label("\(doctor.name)", systemImage: "stethoscope")
                    Label("\(getCurrentDateAsString())", systemImage: "calendar")
                }
            }
            .navigationTitle("New Treatment")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let newTreatment = Treatment(
                            complaint: editedTreatment.complaint,
                            prescription: editedTreatment.prescription,
                            dateString: getCurrentDateAsString(),
                            dateFormat: "yyyy-MM-dd",
                            doctor: doctor
                        )
                        treatments.append(newTreatment)
                        onAddTreatment(newTreatment)
                    }
                }
            }
        }
    }

    private func getCurrentDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    TreatmentAddView(
        treatments: .constant([]),
        patient: Patient.samplePatients[0],
        doctor: Doctor.sampleDoctors[0],
        onAddTreatment: { _ in },
        onCancel: {}
    )
}
