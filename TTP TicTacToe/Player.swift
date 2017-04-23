//
//  Player.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

struct Player {
    
    var name: String
    var symbol: String
    
}

// MARK: Able to compare and equate Photos
extension Player: Equatable {
    static func == (lhs:Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name &&
            lhs.symbol == rhs.symbol
    }
}
