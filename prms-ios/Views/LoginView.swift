//
//  ContentView.swift
//  prms-ios
//
//  Created by Aananth C N on 14/04/24.
//


import SwiftUI

struct LoginView: View {
    var doctors: PrmsUsers  // Ensure doctors is of type PrmsUsers
    @Binding var patients: [Patient]

    @State private var selectedDoctorIndex = 0  // State to track selected doctor index
    @State private var isPresentingDoctorView = false
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void

    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "stethoscope")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Picker("Doctors", selection: $selectedDoctorIndex) {
                    ForEach(0..<doctors.doctors.count, id: \.self) { index in
                        Text(doctors.doctors[index])
                    }
                }
                .pickerStyle(WheelPickerStyle()) // Customize picker style as needed

                Spacer()
                Text("Welcome: \(doctors.doctors[selectedDoctorIndex])")
                    .padding(1.0)
                    .font(.headline)
                NavigationLink(destination: MainView(patients: $patients, searchText: "")) {
                    Text("Login").font(.headline)
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
        } // NavigationStack
        .onChange(of: scenePhase) {oldScenePhase, newScenePhase in
            if newScenePhase == .inactive { saveAction() }
        }
    }
}


#Preview {
    LoginView(doctors: PrmsUsers.sampleUsers, patients: .constant(Patient.samplePatients), saveAction: {})
}
