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

class GameSquareView: UIView {

    var coordinate: (Int, Int)!
    var player: Player? {
        didSet {
            squareButton.setTitle(player?.symbol, for: .normal)
        }
    }
    var squareButton = UIButton()
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(column: Int, row: Int) {
        self.init(frame: CGRect.zero)
        
        self.coordinate = (column, row)
        
        squareButton.addTarget(self, action: #selector(squareSelected), for: .touchUpInside)
        
        addSubview(squareButton)
        squareButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    

}

extension GameSquareView {
    
    func squareSelected() {
        print("Square in column \(coordinate), row \(coordinate) was selected")
    }
    
}
