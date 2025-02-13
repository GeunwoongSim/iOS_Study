//
//  CategoryRow.swift
//  Landmarks
//
//  Created by 심근웅 on 2/12/25.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
                
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0){
                    ForEach(items){ item in
                        NavigationLink(destination: LandmarkDetail(landmark: item)){
                            CategoryItem(landmark: item)
                        }
                        
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

#Preview {
    let landmarks = ModelData().landmarks
        return CategoryRow(
            categoryName: landmarks[0].category.rawValue,
            items: Array(landmarks.prefix(3))
        )
}
