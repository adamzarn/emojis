//
//  ContentView.swift
//  Emojis
//
//  Created by Adam Zarn on 11/1/21.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: ContentViewModel = ContentViewModel()
    
    var balanceText: some View {
        Text(viewModel.balanceText ?? "$0.00").font(.largeTitle)
    }
    
    var spinButton: some View {
        Button(action: { viewModel.spin() }, label: { Text("Spin") })
    }
    
    var newGameButton: some View {
        Button(action: { viewModel = ContentViewModel() }, label: { Text("New Game") })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            EmojiContainerView(content: {
                ForEach(viewModel.emojis, id: \.id) { emoji in
                    EmojiView<AnyShape>(emoji: emoji)
                }
            })
            Spacer()
            CenteredView(content: { balanceText })
            Spacer()
            CenteredView(content: { spinButton })
            Spacer()
            CenteredView(content: { newGameButton })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
