//
//  Emoji.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

struct Emoji: Identifiable {
    let id = UUID()
    let shapeAttribute: ShapeAttribute
    let colorAttribute: ColorAttribute
    let shadingAttribute: ShadingAttribute
}
