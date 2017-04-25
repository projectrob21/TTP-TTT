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
    var squaresAvailable = Set<Coordinate>()
    
    var isComputerPlaying = false
    
    var winningSets: Set<Set<Int>>
    let leftDiagWin: Set = [1, 5, 9]
    let rightDiagWin: Set = [3, 5, 7]
    
    var alertViewDelegate: AlertViewDelegate?
    var computerTurnDelegate: ComputerTurnDelegate?
    
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
        
        squaresAvailable.removeAll()
        for column in 1...3 {
            for row in 1...3 {
                squaresAvailable.insert(Coordinate(column: column, row: row))
            }
        }
        
        
    }
    
}

extension GameViewModel {
    
    func squareSelected(at button: UIButton) {
        if let squareButton = button as? GameSquareButton {
            if squareButton.square.player == nil {
                // Set up square
                squareButton.square.player = currentPlayer
                squareButton.setTitle(currentPlayer.symbol, for: .normal)
                
                // Add squareNum to Set
                currentPlayer.squares.insert(squareButton.square.number)
                movesTaken += 1
                
                // Check for win
                if movesTaken >= 4 {
                    if checkForWin(at: squareButton.square.coordinate) {
                        // resetGame()
                        alertViewDelegate?.presentAlert(for: currentPlayer)
                        return
                    }
                }
                
                // Tie: No winner found after 9 moves
                if movesTaken == 9 {
                    alertViewDelegate?.presentAlert(for: nil)
                    return
                }
                
                // If no winner or tie, change player
                changeCurrentPlayer()
                if currentPlayer.type == .computer {
                    squaresAvailable.remove(squareButton.square.coordinate)
                    computerSquareSelection()
                }
            }
        }
    }
    
    func computerSquareSelection() {
        let timer = Timer.init(timeInterval: 2, repeats: false) { (timer) in
            let squaresArray = Array(self.squaresAvailable)
            let index = arc4random_uniform(UInt32(squaresArray.count - 1))
            let squareCoordinate = squaresArray[Int(index)]
            
            self.computerTurnDelegate?.computerChoseSquare(at: squareCoordinate)
            timer.invalidate()
        }
        timer.fire()
    }
    
    func changeCurrentPlayer() {
        if currentPlayer.symbol == store.playerOne.symbol {
            if isComputerPlaying {
                currentPlayer = store.computer
            } else {
                currentPlayer = store.playerTwo
            }
        } else if currentPlayer.symbol == store.computer.symbol || currentPlayer.symbol == store.playerTwo.symbol {
            currentPlayer = store.playerOne
        }
    }
    
    func checkForWin(at coordinate: Coordinate) -> Bool {
        var didWin = false
        
        // Using Set only
        for set in winningSets {
            if set.isSubset(of: currentPlayer.squares) {
                currentPlayer.wins += 1
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
        store.playerTwo.squares.removeAll()
        store.playerOne.squares.removeAll()
        store.computer.squares.removeAll()
        /*
        store.playerTwo.columnDict = [:]
        store.playerOne.columnDict = [:]
        store.computer.columnDict = [:]
        
        store.playerOne.rowDict = [:]
        store.playerTwo.rowDict = [:]
        store.computer.rowDict = [:]
        */
        movesTaken = 0
        
        squaresAvailable.removeAll()
        for column in 1...3 {
            for row in 1...3 {
                squaresAvailable.insert(Coordinate(column: column, row: row))
            }
        }
        
    }
    
}
