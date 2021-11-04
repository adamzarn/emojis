//
//  ContentView.swift
//  Emojis
//
//  Created by Adam Zarn on 11/1/21.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        return path
    }
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
            .fill(Color.red, strokeBorder: Color.red, lineWidth: 2, fillOpacity: 0.5)
            .previewLayout(.fixed(width: 200, height: 300))
    }
}

struct Emoji: Identifiable {
    let id = UUID()
    let shapeAttribute: ShapeAttribute
    let colorAttribute: ColorAttribute
    let shadingAttribute: ShadingAttribute
}

struct EmojiView: View {
    var emoji: Emoji
    
    var body: some View {
        switch emoji.shapeAttribute {
        case .triangle0, .triangle90, .triangle180, .triangle270:
            Triangle().fill(emoji: emoji).shape(rotatedBy: emoji.shapeAttribute.rotationDegrees)
        case .square:
            Rectangle().fill(emoji: emoji).shape(rotatedBy: emoji.shapeAttribute.rotationDegrees)
        case .diamond:
            Diamond().fill(emoji: emoji).shape(rotatedBy: emoji.shapeAttribute.rotationDegrees)
        case .circle:
            Circle().fill(emoji: emoji).shape(rotatedBy: emoji.shapeAttribute.rotationDegrees)
        }
    }
}

struct ContentViewModel {
    var emojis: [Emoji] = [] {
        didSet {
            currentAngle = 0
        }
    }
    var currentAngle: Double = 0
    
    var balance: Int = 100

    var balanceText: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: balance))
    }
    
    init() {
        setRandomEmojis()
    }
    
    mutating func setRandomEmojis() {
        emojis = [getRandomEmoji(),
                  getRandomEmoji(),
                  getRandomEmoji()].compactMap { $0 }
    }
    
    func getRandomEmoji() -> Emoji? {
        let randomShapeValue = Int.random(in: 0...6)
        let randomColorValue = Int.random(in: 0...3)
        let randomShadingValue = Int.random(in: 0...2)
        
        guard let randomShapeAttribute = ShapeAttribute(rawValue: randomShapeValue),
              let randomColorAttribute = ColorAttribute(rawValue: randomColorValue),
              let randomShadingAttribute = ShadingAttribute(rawValue: randomShadingValue) else { return nil }
        
        return Emoji(shapeAttribute: randomShapeAttribute,
                     colorAttribute: randomColorAttribute,
                     shadingAttribute: randomShadingAttribute)
    }
    
    mutating func spin() {
        balance -= 5
        setRandomEmojis()
        updateBalanceForTwoMatches()
        updateBalanceForAllSameOrAllDifferent()
    }
    
    mutating func updateBalanceForTwoMatches() {
        if Set(emojis.map { $0.shapeAttribute }).twoMatch {
            print("two shapes match")
            balance += 10
            print(balance)
        }
        if Set(emojis.map { $0.colorAttribute }).twoMatch {
            print("two colors match")
            balance += 10
            print(balance)
        }
        if Set(emojis.map { $0.shadingAttribute }).twoMatch {
            print("two shades match")
            balance += 10
            print(balance)
        }
    }
    
    mutating func updateBalanceForAllSameOrAllDifferent() {
        let shapesAreAllSameOrAllDifferent = Set(emojis.map { $0.shapeAttribute }).allSameOrAllDifferent
        let colorsAreAllSameOrAllDifferent = Set(emojis.map { $0.colorAttribute }).allSameOrAllDifferent
        let shadingsAreAllSameOrAllDifferent = Set(emojis.map { $0.shadingAttribute }).allSameOrAllDifferent
        
        let results = [
            shapesAreAllSameOrAllDifferent,
            colorsAreAllSameOrAllDifferent,
            shadingsAreAllSameOrAllDifferent
        ]
        
        let trueCount = results.filter({ $0 == true }).count
        
        if trueCount == 1 {
            print("1 is all same or all different")
            balance += 100
            print(balance)
        } else if trueCount == 2 {
            print("2 is all same or all different")
            balance += 500
            print(balance)
        } else if trueCount == 3 {
            print("3 is all same or all different")
            balance += 1000
            print(balance)
        }
    }
}

extension Set {
//    let array = [1,2,3] => Set(array) = [1,2,3] => count = 3
//    let array = [1,2,2] => Set(array) = [1,2] => count = 2
    
    var twoMatch: Bool {
        return count == 2
    }
    
    var allSameOrAllDifferent: Bool {
        return count == 1 || count == 3
    }
}

struct EmojiContainerView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack { content }.padding()
    }
}

struct ContentView: View {
    @State var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            EmojiContainerView(content: {
                ForEach(viewModel.emojis, id: \.id) { emoji in
                    EmojiView(emoji: emoji)
                        .rotationEffect(.degrees(viewModel.currentAngle))
                        .animation(.easeIn, value: viewModel.currentAngle)
                }
            })
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text(viewModel.balanceText ?? "")
                Spacer()
            }
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Button(action: {
                    viewModel.currentAngle = 360
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.viewModel.spin()
                    })
                }, label: {
                    Text("Spin")
                })
                Spacer()
            }
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Button(action: {
                    viewModel = ContentViewModel()
                }, label: {
                    Text("New Game")
                })
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func shape(rotatedBy degrees: Double = 0) -> some View {
        modifier(ShapeModifier(degrees: degrees))
    }
}

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
