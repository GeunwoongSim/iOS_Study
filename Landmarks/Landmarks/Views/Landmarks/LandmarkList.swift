//
//  LandmarkList.swift
//  Building lists and navigation
//
//  Created by 심근웅 on 2/10/25.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modelData: ModelData
    @State private var showFavoritesOnly: Bool = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter{ $0.isFavorite || !showFavoritesOnly }
    }
    var body: some View {
        NavigationSplitView() {
            List {
                Toggle(isOn: $showFavoritesOnly, label: {
                    Text("Favorites only")
                })
                ForEach(filteredLandmarks) {
                    landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }.navigationTitle("Landmarks")
                .animation(.default, value: filteredLandmarks)
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
