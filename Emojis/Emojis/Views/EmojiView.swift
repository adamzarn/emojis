//
//  EmojiView.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

struct EmojiView<Content: Shape>: View {
    var emoji: Emoji
    var content: AnyShape
    
    init(emoji: Emoji) {
        self.emoji = emoji
        self.content = emoji.shapeAttribute.shape
    }
    
    var body: some View {
        content
            .fill(emoji: emoji)
            .shape(rotatedBy: emoji.shapeAttribute.rotationDegrees)
    }
}
