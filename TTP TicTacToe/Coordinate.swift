//
//  Coordinate.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/24/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

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
    
    public var hashValue: Int {
        return self.column.hashValue << MemoryLayout<Coordinate>.size ^ self.row.hashValue
    }
}
