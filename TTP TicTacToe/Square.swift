//
//  Square.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

//typealias Coordinate = (column: Int, row: Int)

struct Coordinate: Hashable {
 
    let column: Int
    let row: Int
    
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
    
    static func == (lhs:Coordinate, rhs: Coordinate) -> Bool {
        return lhs.column == rhs.column &&
            lhs.row == rhs.row
    }
    
    // TODO research hashable protocol
    public var hashValue: Int {
        return self.column.hashValue << MemoryLayout<Coordinate>.size ^ self.row.hashValue
    }
}

struct Square {
    
    var player: Player?
    
    var coordinate: Coordinate!
    var number: Int!
    init(column: Int, row: Int, number: Int) {
        self.coordinate = Coordinate(column: column, row: row)
        self.number = number
    }

}

// MARK: Able to compare and equate Squares
extension Square: Equatable {
    static func == (lhs:Square, rhs: Square) -> Bool {
        return lhs.number == rhs.number &&
            lhs.player == rhs.player &&
            lhs.coordinate == rhs.coordinate
    }
}
