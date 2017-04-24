//
//  GameViewModel.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

final class GameViewModel {
    
    let store = DataStore.shared
    var currentPlayer: Player!
    
    init() {
        currentPlayer = store.playerOne
    }
    
    func turnTaken() {

        if currentPlayer.symbol == store.playerOne.symbol {
            currentPlayer = store.playerTwo
        } else if currentPlayer.symbol == store.playerTwo.symbol {
            currentPlayer = store.playerOne
        }
    }
    
    func squareSelected(at button: UIButton) {
        if let squareButton = button as? GameSquareButton {
            if squareButton.square.player == nil {
            currentPlayer.squares.append(squareButton.square)
            squareButton.setTitle(currentPlayer.symbol, for: .normal)
            squareButton.square.player = currentPlayer
            turnTaken()
            }
        }
    }
    
    func resetGame() {
        store.playerTwo.squares = []
        store.playerOne.squares = []
        
        
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
}
