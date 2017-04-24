//
//  Player.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

final class Player {
    
    var name: String
    var symbol: String
    var squares = [Square]()
    var wins = 0
    var losses = 0

    
    // [Column # : Count]
    var columnDictionary = [Int: Int]()
    var rowDictionary = [Int: Int]()
    
    
    var columns = Set<Int>()
    var rows = Set<Int>()

    
    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
    }
    
}

// MARK: Able to compare and equate Photos
extension Player: Equatable {
    static func == (lhs:Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name &&
            lhs.symbol == rhs.symbol &&
            lhs.squares == rhs.squares
    }
}
