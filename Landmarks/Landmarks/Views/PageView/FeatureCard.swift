//
//  FeatureCard.swift
//  Landmarks
//
//  Created by 심근웅 on 2/13/25.
//

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark
    var body: some View {
        landmark.featureImage?
            .resizable()
            .overlay {
                TextOverlay(landmark: landmark)
            }
    }
}
struct TextOverlay: View {
    var landmark: Landmark
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading, content: {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }).padding()
        }
        .foregroundStyle(Color.white)
    }
}

#Preview {
    FeatureCard(landmark: ModelData().landmarks[0]).aspectRatio(3/2, contentMode: .fit)
}
