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
    var movesTaken = 0
    
    init() {
        currentPlayer = store.playerOne
    }
    
}

extension GameViewModel {
    
    func squareSelected(at button: UIButton) {
        if let squareButton = button as? GameSquareButton {
            if squareButton.square.player == nil {
//                currentPlayer.squares.append(squareButton.square)
                squareButton.square.player = currentPlayer
                squareButton.setTitle(currentPlayer.symbol, for: .normal)
                
                let column = squareButton.square.coordinate.column
                let row = squareButton.square.coordinate.row
                
                if currentPlayer.columnDictionary[column] == nil {
                    currentPlayer.columnDictionary[squareButton.square.coordinate.column] = 1
                } else {
                    currentPlayer.columnDictionary[squareButton.square.coordinate.column] = currentPlayer.columnDictionary[squareButton.square.coordinate.column]! + 1
                }
                
                
                if currentPlayer.rowDictionary[row] == nil {
                    currentPlayer.rowDictionary[row] = 1
                } else {
                    currentPlayer.rowDictionary[squareButton.square.coordinate.row] = currentPlayer.rowDictionary[row]! + 1
                }
                
                if movesTaken >= 4 {
                    if checkForWin(at: squareButton.square.coordinate) {
                        print("WINNNN")
//                        resetGame()
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
    
    
    
    func checkForWin(at coordinate: Coordinate) -> Bool {
        print("checking for win")

        var didWin = false
        
        if currentPlayer.columnDictionary[coordinate.column] == 3 || currentPlayer.rowDictionary[coordinate.row] == 3 {
            didWin = true
            return didWin
        } /* TODO: Program diagonal wins */
        return didWin
    }
    
    func resetGame() {
        print("reset")
        store.playerTwo.squares = []
        store.playerOne.squares = []
        
        store.playerTwo.columnDictionary = [:]
        store.playerOne.columnDictionary = [:]
        
        store.playerOne.rowDictionary = [:]
        store.playerTwo.rowDictionary = [:]
        
        movesTaken = 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
