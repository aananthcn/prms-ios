//
//  ContentView.swift
//  prms-ios
//
//  Created by Aananth C N on 14/04/24.
//


import SwiftUI

struct MainView: View {
    var doctors: PrmsUsers  // Ensure doctors is of type PrmsUsers
    @State private var selectedDoctorIndex = 0  // State to track selected doctor index
    @State private var isPresentingDoctorView = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "stethoscope")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                //Spacer()
                Picker("Doctors", selection: $selectedDoctorIndex) {
                    ForEach(0..<doctors.doctors.count, id: \.self) { index in
                        Text(doctors.doctors[index])
                    }
                }
                .pickerStyle(WheelPickerStyle()) // Customize picker style as needed
                
                Text("Welcome: \(doctors.doctors[selectedDoctorIndex])")
                    .padding(1.0)
                    .font(.headline)
                NavigationLink(destination: PatientListView(patients: Patient.samplePatients, pat_search: "")) {
                    Text("Login")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Arutjothi PRMS")
            .toolbar {
                Button(action:{
                    isPresentingDoctorView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Doctor")
            }
        }
    }
}


#Preview {
    MainView(doctors: PrmsUsers.sampleUsers)
}
