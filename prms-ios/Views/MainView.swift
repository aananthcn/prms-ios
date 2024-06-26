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
    @State private var isExportOperationActive = false
    @State private var isImportOperationActive = false

    @State private var searchModifierState: Int = 0
    @State private var searchText: String = "" // State to store search text
    @State private var searchTextHelper: String = "Patient Search"


    // Computed property to filter patients based on search text
    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            // If search text is empty, return all patients
            return patients
        } else if searchModifierState == 1 {
            // Filter patients based on treatment
            return patients.filter { patient in
                patient.treatments.contains { treatment in
                    treatment.prescription.localizedCaseInsensitiveContains(searchText)
                }
            }
        } else if searchModifierState == 2 {
            // Filter patients based on complaint
            return patients.filter { patient in
                patient.treatments.contains { treatment in
                    treatment.complaint.localizedCaseInsensitiveContains(searchText)
                }
            }
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
                    TextField(searchTextHelper, text: $searchText)
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
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Change search state on button press
                        searchModifierState = (searchModifierState + 1) % 3

                        // Update search text helper
                        switch searchModifierState {
                        case 0:
                            searchTextHelper = "Patient Search"
                        case 1:
                            searchTextHelper = "Prescription Search"
                        case 2:
                            searchTextHelper = "Complaint Search"
                        default:
                            searchTextHelper = "Patient Search"
                        }
                    }) {
                        Image(systemName: "text.magnifyingglass")
                            .foregroundColor(getForegroundColor())
                    }
                    .accessibilityLabel("Toggle Search Mode")
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isExportOperationActive = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .accessibilityLabel("Export Patients")
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isImportOperationActive = true
                    }) {
                        Image(systemName: "square.and.arrow.down")
                    }
                    .accessibilityLabel("Export Patients")
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
            .sheet(isPresented: $isExportOperationActive) {
                if isExportOperationActive {
                    ExportFileView(
                        isPresented: $isExportOperationActive, patients: patients
                    )
                } else {
                    // Handle error while getting URL
                    // For example, show an alert
                    Text("Error occurred")
                }
            }
            .sheet(isPresented: $isImportOperationActive) {
                ImportFileView(isPresented: $isImportOperationActive) { url in
                    importAndMergePatients(from: url)
                }
            }
        }
    }

    // Helper function to determine foreground color based on search state
    private func getForegroundColor() -> Color {
        switch searchModifierState {
        case 0:
            return .blue
        case 1:
            return Color(red: 0.0, green: 0.9, blue: 0.2)
        case 2:
            return .red
        default:
            return .blue
        }
    }

    @MainActor private func importAndMergePatients(from url: URL) {
        do {
            if url.startAccessingSecurityScopedResource() {
                let patientsStore = PatientsStore() // Create an instance of PatientsStore
                let importedPatients = try patientsStore.load(from: url)

                for importedPatient in importedPatients {
                    if let existingPatientIndex = patients.firstIndex(where: { existingPatientMatches(importedPatient, existingPatient: $0) }) {
                        // Patient with matching fields found
                        for importedTreatment in importedPatient.treatments {
                            if !patients[existingPatientIndex].treatments.contains(where: { $0.id == importedTreatment.id }) {
                                // Treatment with same ID not found, append to existing patient's treatments
                                patients[existingPatientIndex].treatments.append(importedTreatment)
                            }
                        }
                        // Update other details of the existing patient
                        patients[existingPatientIndex].updateDetails(from: importedPatient)
                    } else {
                        // No existing patient with matching fields, append the imported patient
                        patients.append(importedPatient)
                    }
                }
                url.stopAccessingSecurityScopedResource()
            }
        } catch {
            // Handle error while importing patients
            print("Error importing patients: \(error)")
        }
    }

    private func existingPatientMatches(_ importedPatient: Patient, existingPatient: Patient) -> Bool {
        // Compare phone number and, if phone number is empty, also compare name
        return (!existingPatient.phone.isEmpty && existingPatient.phone == importedPatient.phone) ||
               (existingPatient.phone.isEmpty && existingPatient.name == importedPatient.name)
    }


}



#Preview {
    MainView(patients: .constant(Patient.samplePatients), doctors: .constant(Doctor.sampleDoctors), currDoctorIndex: .constant(0))
}
