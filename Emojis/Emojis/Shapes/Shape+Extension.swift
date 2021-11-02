//
//  Shape+Extension.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill,
                                                    strokeBorder strokeStyle: Stroke,
                                                    lineWidth: CGFloat = 2,
                                                    fillOpacity: CGFloat) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle).opacity(Double(fillOpacity)))
    }
    
    func fill(emoji: Emoji) -> some View {
        self.fill(emoji.colorAttribute.color,
                  strokeBorder: emoji.colorAttribute.color,
                  fillOpacity: emoji.shadingAttribute.fillOpacity)
    }
}
