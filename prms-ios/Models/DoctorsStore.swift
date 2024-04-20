//
//  DoctorsStore.swift
//  prms-ios
//
//  Created by Aananth C N on 20/04/24.
//

import Foundation

@MainActor
class DoctorsStore: ObservableObject {
    @Published var doctors: [Doctor] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("doctors.data")
    }
    
    func load() async throws  {
        let task = Task<[Doctor], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            
            let doctorsData = try JSONDecoder().decode([Doctor].self, from: data)
            return doctorsData
        }
        
        let doctors = try await task.value
        self.doctors = doctors
    }
    
    func save(doctors: [Doctor]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(doctors)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
