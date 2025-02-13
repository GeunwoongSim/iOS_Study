//
//  ContentView.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/13/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var calculator: Calculator
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal, content: {
                Text("\(calculator.num, specifier: "%.2f")")
                    .font(Font.system(size: 75))
                    .bold()
            })
            .scrollIndicators(.hidden)
            .defaultScrollAnchor(.trailing)
            PadUI().environmentObject(calculator)
        }.padding()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainView(calculator: Calculator())
}
