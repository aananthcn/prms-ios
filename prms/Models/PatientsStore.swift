//
//  PatientsStore.swift
//  prms
//
//  Created by Aananth C N on 18/04/24.
//

import Foundation

@MainActor
class PatientsStore: ObservableObject {
    @Published var patients: [Patient] = []
    
    static func fileURL() throws -> URL {
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
                return []
            }
            
            let patientsData = try JSONDecoder().decode([Patient].self, from: data)
            return patientsData
        }
        
        let patients = try await task.value
        self.patients = patients
    }

    // Overloaded load function to handle merging of imported patients with existing ones
    func load(from url: URL) throws -> [Patient] {
        let data = try Data(contentsOf: url)
        let importedPatients = try JSONDecoder().decode([Patient].self, from: data)
        return importedPatients
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
