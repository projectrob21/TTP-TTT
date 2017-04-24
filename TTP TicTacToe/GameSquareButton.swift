//
//  GameSquare.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class GameSquareButton: UIButton {
    
    var square: Square! {
        didSet {
            if let player = square.player {
                self.setTitle(player.symbol, for: .normal)
            }
        }
    }
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(column: Int, row: Int) {
        self.init(frame: CGRect.zero)
        
        self.square = Square(column: column, row: row)
        self.backgroundColor = UIColor().generateRandomColor()
    }
    
    
    
}
