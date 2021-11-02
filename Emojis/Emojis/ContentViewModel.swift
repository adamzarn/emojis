//
//  ContentViewModel.swift
//  Emojis
//
//  Created by Adam Zarn on 11/2/21.
//

import Foundation
import SwiftUI

struct ContentViewModel {
    var emojis: [Emoji] = [] {
        didSet {
            guard oldValue.count == 3 else { return }
            balance -= 5
        }
    }
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
        setRandomEmojis()
        updateBalanceForTwoMatches()
        updateBalanceForAllSameOrAllDifferent()
    }
    
    mutating func updateBalanceForTwoMatches() {
        if Set(emojis.map { $0.shapeAttribute }).atLeastTwoMatch {
            print("two shapes match")
            balance += 10
            print(balance)
        }
        if Set(emojis.map { $0.colorAttribute }).atLeastTwoMatch {
            print("two colors match")
            balance += 10
            print(balance)
        }
        if Set(emojis.map { $0.shadingAttribute }).atLeastTwoMatch {
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
    var atLeastTwoMatch: Bool {
        return count <= 2
    }
    
    var allSameOrAllDifferent: Bool {
        return count == 1 || count == 3
    }
}
