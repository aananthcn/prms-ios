//
//  PrmsStore.swift
//  prms-ios
//
//  Created by Aananth C N on 18/04/24.
//

import Foundation

@MainActor
class PatientStore: ObservableObject {
    @Published var patients: [Patient] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("patients.data")
    }
    
    func load() async throws  {
        let task = Task<[Patient], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                //return []
                //TODO: The above lines above and below will be fixed after store() fn is implemented
                return Patient.samplePatients
            }
            
            let patientsData = try JSONDecoder().decode([Patient].self, from: data)
            //return patientsData
            //TODO: The above lines above and below will be fixed after store() fn is implemented
            return Patient.samplePatients
        }
        
        let patients = try await task.value
        self.patients = patients
    }
    
    func save(patients: [Patient]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(patients)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
