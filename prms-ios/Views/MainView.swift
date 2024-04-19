//
//  PatientListView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import SwiftUI


struct MainView: View {
    //@State var patients: [Patient]
    @Binding var patients: [Patient]
    @State private var isPresentingPatientView = false
    @State var searchText: String = "" // State to store search text

    // Computed property to filter patients based on search text
    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            // If search text is empty, return all patients
            return patients
        } else {
            // Filter patients whose names contain the search text (case-insensitive)
            return patients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredPatients) { patient in
                NavigationLink(destination: PatientView(patient: $patients[patients.firstIndex(of: patient)!])) {
                                PatientCard(patient: patient)
                }
            }
            .navigationTitle("Patients List")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 2) // Add horizontal padding
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresentingPatientView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Patient")
                }
            }
        }
    }
}



#Preview {
    MainView(patients: .constant(Patient.samplePatients), searchText: "")
}
