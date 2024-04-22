//
//  PatientView.swift
//  prms-ios
//
//  Created by Aananth C N on 16/04/24.
//

import SwiftUI

struct PatientView: View {
    @Binding var patient: Patient  // Binding to patient data
    @Binding var patients: [Patient]

    @State private var isPresentingEditView = false
    @State private var isShowingDeleteAlert = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Array of month names indexed by month number (0-based)
    let monthAbbreviations = [
        "",     // Placeholder for index 0 (months are 1-based)
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ]
   
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Patient Info")) {
                    Label("\(patient.gender)", systemImage: "person")
                    Label("\(patient.phone)", systemImage: "phone")
                    Label("\(patient.email)", systemImage: "mail")
                    HStack {
                        Label(abbreviatedMonth(for:patient.month)+" - \(patient.year)",systemImage: "calendar")
                    }
                }
            }
            .navigationTitle(patient.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action:{
                        isShowingDeleteAlert = true
                    }){
                        Image(systemName: "xmark.bin")
                    }
                    .accessibilityLabel("Delete Patient")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                    .accessibilityLabel("Edit Patient")
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationStack {
                    PatientEditView(patient: $patient)
                        .navigationTitle($patient.name)
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
                Alert(
                    title: Text("Delete Patient"),
                    message: Text("Are you sure you want to delete \(patient.name)?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deletePatient()
                        presentationMode.wrappedValue.dismiss() // Dismiss PatientView
                    },
                    secondaryButton: .cancel()
                )
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

    // delete patient function
    private func deletePatient() {
        patients.removeAll(where: { $0.id == patient.id })
    }
}


#Preview {
    PatientView(
        patient: .constant(Patient.samplePatients[0]),
        patients: .constant(Patient.samplePatients)
    )
}
