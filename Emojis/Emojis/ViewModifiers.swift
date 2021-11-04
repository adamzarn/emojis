//
//  ViewModifiers.swift
//  Emojis
//
//  Created by Adam Zarn on 11/3/21.
//

import Foundation
import SwiftUI

struct ShapeModifier: ViewModifier {
    var degrees: Double
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(degrees))
    }
}
