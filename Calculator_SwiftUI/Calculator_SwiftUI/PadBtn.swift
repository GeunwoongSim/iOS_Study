//
//  PadBtn.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/13/25.
//

import Foundation
import SwiftUI


struct PadBtn: View {
    @EnvironmentObject var calculator: Calculator
    
    var info: ButtonModel
    let backColor: [ButtonType:Color] = [
        .BasicOperation:.orange,
        .Number:.gray,
        .Etc:.brown,
        .Zero:.gray
    ]
    var body: some View {
        let length: CGFloat = (UIScreen.main.bounds.width - 50) / 4
        Button(action: { ButtonAction(info: info) }, label: {
            Text(info.name)
                .frame(width: info.type == .Zero ? length * 2 : length, height: length)
                .bold()
        })
        .frame(width: info.type == .Zero ? length * 2 : length, height: length)
        .background(backColor[info.type]!)
        .cornerRadius(length/2)
        .foregroundStyle(.white)
        .bold()
        .font(.title)
    }
    func ButtonAction(info: ButtonModel){
        if info.type == .Number {
            calculator.num = calculator.num * 10 + (Double(info.name) ?? 0)
        }
        else if info.name == "AC" {
            calculator.num = 0
        }
        print(info.type)
    }
}

#Preview {
    PadBtn(info: ButtonModel(name: "0", type: .Number))
        .environmentObject(Calculator())
}
