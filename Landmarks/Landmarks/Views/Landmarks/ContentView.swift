//
//  ContentView.swift
//  Building lists and navigation
//
//  Created by 심근웅 on 2/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .list
    enum Tab{
        case featured
        case list
    }
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tag(Tab.featured)
                .tabItem({ Label("Feature", systemImage: "star")})
            LandmarkList()
                .tag(Tab.list)
                .tabItem{ Label("List",systemImage: "list.bullet") }
        }
        
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
