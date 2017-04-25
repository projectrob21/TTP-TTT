//
//  Player.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

enum PlayerType {
    case human, computer
}

final class Player {
    
    var id: Int
    var name: String
    var symbol: String
    var type: PlayerType
    var wins = 0
    var squares = Set<Int>()
    
    init(id: Int, name: String, symbol: String, type: PlayerType) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.type = type
    }
    
}

extension Player: Equatable {
    static func == (lhs:Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name &&
            lhs.symbol == rhs.symbol &&
            lhs.squares == rhs.squares
    }
}
