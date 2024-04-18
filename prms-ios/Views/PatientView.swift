//
//  PatientView.swift
//  prms-ios
//
//  Created by Aananth C N on 16/04/24.
//

import SwiftUI

struct PatientView: View {
    //var patient: Patient
    @Binding var patient: Patient  // Binding to patient data
    
    @State private var editingPatient = Patient.emptyPatient
    @State private var isPresentingEditView = false

    // Array of month names indexed by month number (0-based)
    let monthAbbreviations = [
        "",     // Placeholder for index 0 (months are 1-based)
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ]
   
    /*
    init(patient: Binding<Patient>) {
        _patient = patient
        _editingPatient = State(initialValue: patient.wrappedValue)
    }
    */

    var body: some View {
        List {
            Section(header: Text("Patient Info")) {
                Label("\(patient.gender)", systemImage: "person")
                Label("\(patient.phone)", systemImage: "phone")
                Label("\(patient.email)", systemImage: "mail")
                HStack {
                    Label(abbreviatedMonth(for:patient.moye.month)+" - \(patient.moye.year)",systemImage: "calendar")
                }
            }
        }
        .navigationTitle(patient.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                // Assign editingPatient with a copy of the current patient
                editingPatient = patient
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                PatientEditView(patient: editingPatient)
                    .navigationTitle(patient.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                // original patient <== edited patient
                                patient = editingPatient
                            }
                        }
                    }
            }
        }
    }


    // Function to get 3-letter month abbreviation for a given month number
    private func abbreviatedMonth(for monthNumber: Int) -> String {
        guard (1...12).contains(monthNumber) else {
            return "Invalid Month"
        }
        return monthAbbreviations[monthNumber]
    }
}


#Preview {
    PatientView(patient: .constant(Patient.samplePatients[0]))
}
