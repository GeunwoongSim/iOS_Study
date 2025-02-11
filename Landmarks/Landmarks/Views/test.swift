//
//  test.swift
//  Landmarks
//
//  Created by 심근웅 on 2/11/25.
//

import SwiftUI

struct test: View {
    @State var isB: Bool
    @State var state: Int = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        test1(isB: $isB, state: state)
        Button("확인"){
            state += 1
        }
        
    }
}

struct test1: View {
    @Binding var isB: Bool
    var state: Int
    var body: some View {
        Button{
            isB.toggle()
        } label: {
            Text(isB ? "on" : "off")
        }
        Text("\(state)")
    }
}

#Preview {
    test(isB: true)
}
