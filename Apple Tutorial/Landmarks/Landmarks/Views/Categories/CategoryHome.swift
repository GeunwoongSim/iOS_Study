//
//  CategoryHome.swift
//  Landmarks
//
//  Created by 심근웅 on 2/12/25.
//

import SwiftUI

struct CategoryHome: View {
    @Environment(ModelData.self) var modelData
    @State private var showProfile = false
    
    var body: some View {
        NavigationSplitView{
            List {
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id:\.self){ key in
//                    Text(key)
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar(content: {
                Button(action: {
                    showProfile = true
                }, label: {
                    Label("Profile", systemImage: "person.crop.circle")
                })
            }).sheet(isPresented: $showProfile, content: { ProfileHost().environment(modelData) })
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    var modelDate = ModelData()
    CategoryHome().environment(modelDate)
}
