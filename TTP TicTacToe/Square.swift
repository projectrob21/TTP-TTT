//
//  Square.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

typealias Coordinate = (column: Int, row: Int)

struct Square {
    
    var coordinate: Coordinate!
    
    var player: Player?

    init(column: Int, row: Int) {
        self.coordinate = (column, row)
        
    }
}

// MARK: Able to compare and equate Squares
extension Square: Equatable {
    static func == (lhs:Square, rhs: Square) -> Bool {
        return lhs.coordinate == rhs.coordinate &&
            lhs.coordinate == rhs.coordinate &&
            lhs.player == rhs.player
    }
}
