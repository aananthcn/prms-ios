//
//  TreatmentListView.swift
//  prms-ios
//
//  Created by Aananth C N on 21/04/24.
//

import SwiftUI

struct TreatmentListView: View {
    @State private var treatments = Treatment.sampleTreatments
    
    var body: some View {
        NavigationView {
            List {
                ForEach ($treatments) { $treatment in
                    /*
                     NavigationLink(destination: DoctorView(doctor: $doctor, currDoctorIndex: $currDoctorIndex, doctors: $doctors)) {
                     Label(doctor.name, systemImage: "person")
                     }
                     */
                    //Text(treatment.complaint)
                    TreatmentCard(treatment: treatment)
                        .listRowInsets(EdgeInsets(top: 5, leading: 1, bottom: 5, trailing: 1)) // Reduce row insets
                }
            }
            .navigationTitle("Patient Name")
        }
    }
}


#Preview {
    TreatmentListView()
}
