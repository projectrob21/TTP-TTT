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
        
        addSubview(squareButton)
        squareButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    

}
