//
//  CenteredView.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

struct CenteredView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
