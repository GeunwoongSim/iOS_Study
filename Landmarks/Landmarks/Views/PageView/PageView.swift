//
//  PageView.swift
//  Landmarks
//
//  Created by 심근웅 on 2/13/25.
//

import SwiftUI

struct PageView<Page:View>: View {
    var pages: [Page]
    
    var body: some View {
        PageViewController(pages: pages)
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}

#Preview {
    PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
}
