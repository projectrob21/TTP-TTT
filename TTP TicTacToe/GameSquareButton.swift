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
    
    var coordinate: (Int, Int)!
    var player: Player? {
        didSet {
            self.setTitle(player?.symbol, for: .normal)
        }
    }
    
    var square: Square!
    
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
        self.coordinate = (column, row)
        self.backgroundColor = UIColor().generateRandomColor()
    }
    
    
  
}
