//
//  GameView.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class GameView: UIView {

    let column1 = UIStackView()
    let column2 = UIStackView()
    let column3 = UIStackView()

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }

    func configure() {
        let columnArray = [column1, column2, column3]
        
        for stack in columnArray {
            stack.axis = .vertical
            stack.spacing = 0.0
            stack.distribution = .fillEqually
            
            for _ in 1...3 {
                let square = GameSquareView()
                square.backgroundColor = UIColor().generateRandomColor()
                stack.addArrangedSubview(square)
            }
            
        }
    }
    
    func constrain() {
        addSubview(column1)
        column1.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        addSubview(column2)
        column2.snp.makeConstraints {
            $0.leading.equalTo(column1.snp.trailing)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        addSubview(column3)
        column3.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
    }
}
