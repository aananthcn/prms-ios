//
//  MainView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//
//  Lists all patient's card

import SwiftUI


struct MainView: View {
    @Binding var patients: [Patient]
    @Binding var doctors: [Doctor]
    @Binding var currDoctorIndex: Int
    
    @State private var isPresentingPatientAddView = false
    @State private var isPresentingDoctorsView = false
    @State private var searchText: String = "" // State to store search text


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
                NavigationLink(destination: TreatmentListView(patient: $patients[patients.firstIndex(of: patient)!], patients: $patients, doctor: doctors[currDoctorIndex])) {
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
                        // triggers DoctorListView
                        isPresentingDoctorsView = true
                    }) {
                        Image(systemName: "stethoscope")
                    }
                    .accessibilityLabel("View Doctors")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresentingPatientAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Patient")
                }
            }
            .sheet(isPresented: $isPresentingDoctorsView) {
                // show Doctor's list
                DoctorListView(isPresentingDoctorsView: $isPresentingDoctorsView, currDoctorIndex: $currDoctorIndex, doctors: $doctors)
            }
            .sheet(isPresented: $isPresentingPatientAddView) {
                PatientAddView(
                    patients: $patients,
                    onAddPatient: { newPatient in
                        isPresentingPatientAddView = false
                    },
                    onCancel: {
                        // Handle cancel action
                        isPresentingPatientAddView = false
                    }
                )
            }
        }
    }
}



#Preview {
    MainView(patients: .constant(Patient.samplePatients), doctors: .constant(Doctor.sampleDoctors), currDoctorIndex: .constant(0))
}
