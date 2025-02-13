//
//  ButtonModel.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/13/25.
//

import Foundation

struct ButtonModel {
    var name: String
    var type: ButtonType
}

enum ButtonType {
    case Number
    case BasicOperation
    case Etc
    case Zero
}

class Calculator: ObservableObject {
    @Published var num: Double
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    init(num: Double = 0.0) {
        self.num = num
    }
}
