//
//  ComputerViewModel.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/24/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

final class GameViewModel {
    
    let store = DataStore.shared
    var currentPlayer: Player!
    var movesTaken = 0
    
    var winningSets: Set<Set<Int>>
    let leftDiagWin: Set = [1, 5, 9]
    let rightDiagWin: Set = [3, 5, 7]
    
    init() {
        currentPlayer = store.playerOne
        
        
        
        // Alternative Win-checking method
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
    
}

extension GameViewModel {
    
    func squareSelected(at button: UIButton) {
        if let squareButton = button as? GameSquareButton {
            if squareButton.square.player == nil {
                // Set up square
                squareButton.square.player = currentPlayer
                squareButton.setTitle(currentPlayer.symbol, for: .normal)
                
                // Add to player dictionary
                let column = squareButton.square.coordinate.column
                let row = squareButton.square.coordinate.row
                
                
                if currentPlayer.columnDict[column] == nil {
                    currentPlayer.columnDict[squareButton.square.coordinate.column] = 1
                } else {
                    currentPlayer.columnDict[squareButton.square.coordinate.column] = currentPlayer.columnDict[squareButton.square.coordinate.column]! + 1
                }
                
                
                if currentPlayer.rowDict[row] == nil {
                    currentPlayer.rowDict[row] = 1
                } else {
                    currentPlayer.rowDict[squareButton.square.coordinate.row] = currentPlayer.rowDict[row]! + 1
                }
                
                // Add squareNum to Set
                currentPlayer.squares.insert(squareButton.square.number)
                
                // Check for win
                if movesTaken >= 4 {
                    if checkForWin(at: squareButton.square.coordinate) {
                        print("WINNNN")
                        // resetGame()
                        // TODO: Alert Delegate
                    }
                }
                
                
                changeCurrentPlayer()
                computerMove()
            }
        }
    }
    
    func computerMove() {
        
        
        
    }
    
    func changeCurrentPlayer() {
        movesTaken += 1
        if currentPlayer.symbol == store.playerOne.symbol {
            currentPlayer = store.computer
        } else if currentPlayer.symbol == store.computer.symbol {
            currentPlayer = store.playerOne
        }
    }
    
    
    
    func checkForWin(at coordinate: Coordinate) -> Bool {
        print("checking for win: \(currentPlayer.squares)")
        
        var didWin = false
        
        // Using Set only
        for set in winningSets {
            if set.isSubset(of: currentPlayer.squares) {
                didWin = true
                return didWin
            }
        }
        
        /* Using Dictionary and Set
         
        if currentPlayer.columnDict[coordinate.column] == 3 || currentPlayer.rowDict[coordinate.row] == 3 {
            didWin = true
            return didWin
        } else if currentPlayer.squares.isSubset(of: leftDiagWin) || currentPlayer.squares.isSubset(of: rightDiagWin) {
            didWin = true
            return didWin
        }
        */
        
        return didWin
    }
    
    func resetGame() {
        print("reset")
        store.playerTwo.squares.removeAll()
        store.playerOne.squares.removeAll()
        store.computer.squares.removeAll()
        
        store.playerTwo.columnDict = [:]
        store.playerOne.columnDict = [:]
        store.computer.columnDict = [:]
        
        store.playerOne.rowDict = [:]
        store.playerTwo.rowDict = [:]
        store.computer.rowDict = [:]
        
        movesTaken = 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
