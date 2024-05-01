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
                        .listRowInsets(EdgeInsets(top: 0.5, leading: 1, bottom: 0.5, trailing: 1))
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
                    if let patientsDataURL = try? PatientsStore.fileURL() {
                        ExportFileView(
                            url: patientsDataURL,
                            isPresented: $isExportOperationActive
                        )
                    } else {
                        // Handle error while getting URL
                        // For example, show an alert
                        Text("Error occurred")
                    }
                }
            }
            .sheet(isPresented: $isImportOperationActive) {
                ImportFileView(isPresented: $isImportOperationActive) { url in
                    // Handle the imported file URL here
                    print("Imported file URL: \(url)")
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
}



#Preview {
    MainView(patients: .constant(Patient.samplePatients), doctors: .constant(Doctor.sampleDoctors), currDoctorIndex: .constant(0))
}
