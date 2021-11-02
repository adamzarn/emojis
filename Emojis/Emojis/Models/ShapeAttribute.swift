//
//  ShapeAttribute.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
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
    
    var shape: AnyShape {
        switch self {
        case .triangle0, .triangle90, .triangle180, .triangle270: return AnyShape(Triangle())
        case .square: return AnyShape(Rectangle())
        case .circle: return AnyShape(Circle())
        case .diamond: return AnyShape(Diamond())
        }
    }
}
