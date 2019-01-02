//
//  Card.swift
//  Concentration
//
//  Created by Danni on 1/1/19.
//  Copyright © 2019 Danni Chen. All rights reserved.
//

import Foundation

struct Card {
    var identifier:Int
    var isFaceUp = false
    var isMatched = false
    private static var identifierFactory = 0
    
    private static func uniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.uniqueIdentifier()
    }
}
