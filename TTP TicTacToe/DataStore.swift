//
//  DataStore.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class DataStore {
    
    static let shared = DataStore()
    
    let playerOne = Player(name: "Player One", symbol: "❌")
    let playerTwo = Player(name: "Player Two", symbol: "⭕️")

}
