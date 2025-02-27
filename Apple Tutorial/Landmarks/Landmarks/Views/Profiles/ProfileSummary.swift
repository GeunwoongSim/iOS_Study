//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by 심근웅 on 2/12/25.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    @Environment(ModelData.self) var modelData
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username).font(.title).bold()
                Text("Notification: \(profile.prefersNotification ? "On" : "Off")")
                Text("Seasonal Photo: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
            
                Divider()
                Text("Completed Badges")
                    .font(.headline)
                    .bold()
                ScrollView(.horizontal) {
                    HStack() {
                        HikeBadge(name: "First Hike")
                        HikeBadge(name: "Earth Day")
                            .hueRotation(Angle(degrees: 90))
                        HikeBadge(name: "Tenth Hike")
                            .hueRotation(Angle(degrees: 45))
                            .grayscale(0.5)
                    }.padding(.bottom)
                }
                Divider()
                VStack(alignment: .leading){
                    Text("Recent Hikes").font(.headline)
                    HikeView(hike: modelData.hikes[0])
                }
                
            }
        }
    }
}

#Preview {
    ProfileSummary(profile: Profile.default).environment(ModelData())
}
