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
    
    let boardView = UIView()
    var column1 = UIStackView()
    var column2 = UIStackView()
    var column3 = UIStackView()
    
    let resetButton = UIButton()
    
    let gameViewModel = GameViewModel()
    
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
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.red
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        let columnArray = [column1, column2, column3]
        
        var columnNum = 1
        
        for column in columnArray {
            
            column.axis = .vertical
            column.spacing = 0.0
            column.distribution = .fillEqually
            
            var rowNum = 1
            for _ in 1...3 {
                
                let button = GameSquareButton(column: columnNum, row: rowNum)
                button.addTarget(self, action: #selector(squareSelected(_:)), for: .touchUpInside)
                column.addArrangedSubview(button)
                
                rowNum += 1
            }
            columnNum += 1
        }
        
        
    }
    
    func constrain() {
        addSubview(boardView)
        boardView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(boardView.snp.width)
        }
        
        boardView.addSubview(column1)
        column1.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        boardView.addSubview(column2)
        column2.snp.makeConstraints {
            $0.leading.equalTo(column1.snp.trailing)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        boardView.addSubview(column3)
        column3.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        addSubview(resetButton)
        resetButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(boardView.snp.bottom).offset(20)
        }
    }
    
    
    // TODO this is probably terrible for memory
    func resetTicTacToeBoard() {
        
        let columnArray = [column1, column2, column3]
        
        for column in columnArray {
            for squareButton in column.arrangedSubviews {
                if let squareButton = squareButton as? GameSquareButton {
                    if squareButton.square.player != nil {
                        squareButton.square.player = nil
                        squareButton.setTitle("", for: .normal)
                    }
                }
            }
        }
        
    }
    
}

extension GameView {
    
    func squareSelected(_ sender: UIButton) {
        gameViewModel.squareSelected(at: sender)
    }
    
    func resetButtonPressed() {
        resetTicTacToeBoard()
        gameViewModel.resetGame()
    }
}


