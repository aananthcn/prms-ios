//
//  PatientListView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import SwiftUI

struct PatientListView: View {
    @State var patients: [Patient]
    @State private var isPresentingPatientView = false
    @State var pat_search: String

    var body: some View {
        NavigationStack {
            List(patients) { patient in
                PatientCard(patient: patient)
            }
            .navigationTitle("Patients List")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    TextField("Search", text: $pat_search)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 2) // Add horizontal padding
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action:{
                        isPresentingPatientView = true
                    }){
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Patient")
                }
            }
        }
    }
}


#Preview {
    PatientListView(patients: Patient.samplePatients, pat_search: "Search")
}
