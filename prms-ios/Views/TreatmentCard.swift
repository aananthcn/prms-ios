//
//  TreatmentCard.swift
//  prms-ios
//
//  Created by Aananth C N on 21/04/24.
//

import SwiftUI


struct TreatmentCard: View {
    let treatment: Treatment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(treatment.complaint)
                    .font(.headline)
                    .lineLimit(1)
                    .accessibilityAddTraits(.isHeader)
                    .truncationMode(.tail)
            }
            HStack {
                HStack {
                    Image(systemName: "calendar").foregroundColor(.blue)
                    Text(treatment.dateString).lineLimit(1)
                }
                Spacer().frame(width: 20)
                HStack {
                    Image(systemName: "stethoscope").foregroundColor(.blue)
                    Text(treatment.doctor.name)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .accessibilityLabel("Doctor Name")
                }
            }
        } // VStack
        .padding(.horizontal, 0.1)
    }
}


#Preview {
    TreatmentCard(treatment: Treatment.sampleTreatments[0])
}
