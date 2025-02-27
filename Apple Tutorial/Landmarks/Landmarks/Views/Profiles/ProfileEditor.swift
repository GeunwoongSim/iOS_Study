//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by 심근웅 on 2/12/25.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    var body: some View {
        List {
            HStack {
                Text("Username")
                Spacer()
                TextField("Username", text: $profile.username)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            Toggle(isOn: $profile.prefersNotification, label: {
                Text("Enable Notifications")
            })
            Picker("Seasonal Photo",selection: $profile.seasonalPhoto){
                ForEach(Profile.Season.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date,label: {
                Text("Goal Date")
            })
        }
    }
}

#Preview {
    ProfileEditor(profile: .constant(.default))
}
