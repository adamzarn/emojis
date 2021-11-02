//
//  ShadingAttribute.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

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
