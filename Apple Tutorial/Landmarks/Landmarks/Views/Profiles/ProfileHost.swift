//
//  ProfileHost.swift
//  Landmarks
//
//  Created by 심근웅 on 2/12/25.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @Environment(ModelData.self) var modelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }

            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            }else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear(perform: {
                        draftProfile = modelData.profile
                    })
                    .onDisappear(perform: {
                        modelData.profile = draftProfile
                    })
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost().environment(ModelData())
}
