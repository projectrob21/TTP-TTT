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
    
    func squareSelected(at square: UIButton) {
        if let square = square as? GameSquareButton {
            currentPlayer.squares.append(square.square)
            print("\(currentPlayer.name) as selected square at \(square.coordinate)")
//            square.titleLabel?.text = currentPlayer.symbol
            square.setTitle(currentPlayer.symbol, for: .normal)
            turnTaken()
        }
    }

    
}
