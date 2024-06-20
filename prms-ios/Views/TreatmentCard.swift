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
                        .font(.footnote)
                    Text(treatment.dateString).lineLimit(1)
                        .font(.subheadline)
                }
                Spacer()
                HStack {
                    Image(systemName: "stethoscope").foregroundColor(.blue)
                        .font(.footnote)
                    Text(treatment.doctor.name)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .accessibilityLabel("Doctor Name")
                        .font(.subheadline)
                }
            }
        } // VStack
        .padding(.horizontal, 4.0)
    }
}


#Preview {
    TreatmentCard(treatment: Treatment.sampleTreatments[0])
}
