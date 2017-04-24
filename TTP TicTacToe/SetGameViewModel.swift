//
//  GameViewModel.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

final class SetGameViewModel {
    
    let store = DataStore.shared
    var currentPlayer: Player!
    var movesTaken = 0
    let gameMatrix = 3
    var winningSets: Set<Set<Int>>
    
    let winningArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 7]]
    
    init() {
        currentPlayer = store.playerOne

        let a: Set = [1, 2, 3]
        let b: Set = [4, 5, 6]
        let c: Set = [7, 8, 9]
        let d: Set = [1, 4, 7]
        let e: Set = [2, 5, 8]
        let f: Set = [3, 6, 9]
        let g: Set = [1, 5, 9]
        let h: Set = [3, 5, 7]
        
        winningSets = [a, b, c, d, e, f, g, h]
        
    }
    
    func generateWinningSquares(size: Int) {
        
        let total = (size * size)
        
        for number in 1...total {
            
            var rowSize = 1
            for _ in 1...size {
                
                
            }
        }
        
    }
    
    
}

extension SetGameViewModel {
    
    func squareSelected(at button: UIButton) {
        if let squareButton = button as? GameSquareButton {
            if squareButton.square.player == nil {
                // Set up square
                squareButton.square.player = currentPlayer
                squareButton.setTitle(currentPlayer.symbol, for: .normal)
                
                // Add to player Set
                currentPlayer.squares.insert(squareButton.square.number)
                
                // Check for win
                if movesTaken >= 4 {
                    if checkForWin(at: squareButton.square) {
                        print("WINNNN")
                        // resetGame()
                        // TODO: Alert Delegate
                    }
                }
                changeCurrentPlayer()
                
            }
        }
    }
    func changeCurrentPlayer() {
        movesTaken += 1
        print("current player is \(currentPlayer.name)")
        if currentPlayer.symbol == store.playerOne.symbol {
            currentPlayer = store.playerTwo
        } else if currentPlayer.symbol == store.playerTwo.symbol {
            currentPlayer = store.playerOne
        }
    }
    
    
    
    func checkForWin(at square: Square) -> Bool {
        print("checking for win")
        
        var didWin = false
        
        // TODO
        if currentPlayer.name == "WINNER" {
            didWin = true
        }
        return didWin
    }
    
    func resetGame() {
        print("reset")
        store.playerTwo.squares = []
        store.playerOne.squares = []
        
        store.playerTwo.columnDict = [:]
        store.playerOne.columnDict = [:]
        
        store.playerOne.rowDict = [:]
        store.playerTwo.rowDict = [:]
        
        movesTaken = 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
