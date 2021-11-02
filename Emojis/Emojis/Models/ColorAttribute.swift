//
//  ColorAttribute.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

enum ColorAttribute: Int {
    case red = 0
    case blue = 1
    case green = 2
    case purple = 3
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .blue: return Color.blue
        case .green: return Color.green
        case .purple: return Color.purple
        }
    }
}
