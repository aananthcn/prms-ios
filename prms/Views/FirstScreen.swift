//
//  FirstScreen.swift
//  prms
//
//  Created by Aananth C N on 14/04/24.
//


import SwiftUI

struct FirstScreen: View {
    @Binding var doctors: [Doctor]
    @Binding var patients: [Patient]

    @State private var selectedDoctorIndex = 0  // State to track selected doctor index
    @State private var isPresentingDoctorAddView = false

    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void

    
    var body: some View {
        NavigationStack {
            VStack {
                if !doctors.isEmpty {
                    // Add a Text view to display the version information
                    Text("Version \(AppInfo.version) (build:\(AppInfo.build))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "stethoscope")
                        .imageScale(.large)
                        //.foregroundStyle(.tint)
                        .foregroundColor(.yellow)
                    
                    // Doctor selected here will be used in all data entries
                    Picker("Doctors", selection: $selectedDoctorIndex) {
                        ForEach(doctors.indices, id: \.self) { index in
                            Text(doctors[index].name) // Display doctor's name in the Picker
                        }
                    }
                    .pickerStyle(WheelPickerStyle()) // Customize picker style as needed
                    
                    Spacer()
                    Text("Welcome: \(doctors[selectedDoctorIndex].name)")
                        .padding(1.0)
                        .font(.headline)
                    
                    // Entry into MainView
                    NavigationLink(destination: MainView(patients: $patients, doctors: $doctors, currDoctorIndex: $selectedDoctorIndex)) {
                        Text("Select Doctor").font(.headline)
                    }
                    Spacer()
                } else {
                    Text("No doctors available, please add doctors.")
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Arutjothi PRMS")
            .toolbar {
                Button(action:{
                    isPresentingDoctorAddView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Doctor")
            }
            .sheet(isPresented: $isPresentingDoctorAddView) {
                DoctorAddView(
                    doctors: $doctors,
                    onAddDoctor: { newDoctor in
                        isPresentingDoctorAddView = false
                    },
                    onCancel: {
                        // Handle cancel action
                        isPresentingDoctorAddView = false
                    }
                )
            }
        } // NavigationStack
        .onChange(of: scenePhase) {oldScenePhase, newScenePhase in
            if newScenePhase == .inactive { saveAction() }
        }
    }
}


#Preview {
    FirstScreen(doctors: .constant(Doctor.sampleDoctors), patients: .constant(Patient.samplePatients), saveAction: {})
}
