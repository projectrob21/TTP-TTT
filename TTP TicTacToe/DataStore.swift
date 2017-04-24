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
    
    var playerOne = Player(name: "Player One", symbol: "⚗️")
    var playerTwo = Player(name: "Player Two", symbol: "🔮")
    var computer = Player(name: "Computer", symbol: "🤖")

}
