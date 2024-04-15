//
//  PatientListView.swift
//  prms-ios
//
//  Created by Aananth C N on 15/04/24.
//

import SwiftUI

struct PatientListView: View {
    let patients: [Patient]

    var body: some View {
        NavigationStack {
            List(patients) { patient in
                PatientView(patient: patient)
            }
            .navigationTitle("Patients List")
        }
    }
}


#Preview {
    PatientListView(patients: Patient.samplePatients)
}
