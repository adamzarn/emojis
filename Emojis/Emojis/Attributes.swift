//
//  Attributes.swift
//  Emojis
//
//  Created by Adam Zarn on 11/3/21.
//

import Foundation
import SwiftUI

enum ShapeAttribute: Int {
    case triangle0 = 0
    case triangle90 = 1
    case triangle180 = 2
    case triangle270 = 3
    case square = 4
    case circle = 5
    case diamond = 6
    
    var rotationDegrees: Double {
        switch self {
        case .triangle0: return 0
        case .triangle90: return 90
        case .triangle180: return 180
        case .triangle270: return 270
        case .square: return 0
        case .circle: return 0
        case .diamond: return 0
        }
    }
}

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

enum ShadingAttribute: Int {
    case none = 0
    case translucent = 1
    case opaque = 2
    
    var fillOpacity: CGFloat {
        switch self {
        case .none: return 0
        case .translucent: return 0.2
        case .opaque: return 1
        }
    }
}
