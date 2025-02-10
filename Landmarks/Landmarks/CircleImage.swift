//
//  CircleImage.swift
//  Landmarks
//
//  Created by 심근웅 on 2/10/25.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(.circle)
            .overlay{ Circle().stroke(.white, lineWidth: 4) }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}
