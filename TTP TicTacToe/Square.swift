//
//  Square.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

struct Square {
    
    var coordinate: (Int, Int) {
        didSet {
            self.column = coordinate.0
            self.row = coordinate.1
        }
    }
    var column: Int!
    var row: Int!
    
    var player: Player?

    init(column: Int, row: Int) {
        self.coordinate = (column, row)
        
    }
}

// MARK: Able to compare and equate Squares
extension Square: Equatable {
    static func == (lhs:Square, rhs: Square) -> Bool {
        return lhs.coordinate == rhs.coordinate &&
            lhs.column == rhs.column &&
            lhs.row == rhs.row &&
            lhs.player == rhs.player
    }
}
