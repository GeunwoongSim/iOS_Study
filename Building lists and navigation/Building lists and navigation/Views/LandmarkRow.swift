//
//  LandmarkRow.swift
//  Building lists and navigation
//
//  Created by 심근웅 on 2/10/25.
//

import SwiftUI

struct LandmarkRow: View {
    var image: Image
    var name: String
    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 50, height: 50)
            Text(name)
            Spacer()
        }.padding()
    }
}

#Preview {
    Group {
        LandmarkRow(image: landmarks[0].image, name: landmarks[0].name)
        LandmarkRow(image: landmarks[1].image, name: landmarks[1].name)
    }
}
