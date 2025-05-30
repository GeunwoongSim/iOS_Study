//
//  HikeBadge.swift
//  Landmarks
//
//  Created by 심근웅 on 2/12/25.
//

import SwiftUI

struct HikeBadge: View {
    var name: String
    
    var body: some View {
        VStack {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name)")
        }
        
    }
}

#Preview {
    HikeBadge(name: "Preview Testing")
}
