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
    
    let store = DataStore.shared
    
    let boardView = UIView()
    var column1 = UIStackView()
    var column2 = UIStackView()
    var column3 = UIStackView()
    
    let spacing: CGFloat = 5.0
    
    // TODO fix textfields
    var playerOneNameTextfield = UITextField() {
        didSet {
            store.playerOne.name = playerOneNameTextfield.text!
        }
    }
    var playerTwoNameTextfield = UITextField() {
        didSet {
            store.playerTwo.name = playerTwoNameTextfield.text!
        }
    }
    var playerOneSymbolTextfield = UITextField()
    var playerTwoSymbolTextfield = UITextField()
    
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
        
        backgroundColor = UIColor.white
        boardView.backgroundColor = UIColor.black
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.red
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        playerOneNameTextfield.placeholder = store.playerOne.name
        playerTwoNameTextfield.placeholder = store.playerTwo.name
        
        playerOneSymbolTextfield.placeholder = store.playerOne.symbol
        playerTwoSymbolTextfield.placeholder = store.playerTwo.symbol
        
        let columnArray = [column1, column2, column3]
        
        var columnNum = 1
        
        for column in columnArray {
            
            column.axis = .vertical
            column.spacing = spacing
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
            $0.width.equalToSuperview().dividedBy(3).offset(-spacing/2)
        }
        
        boardView.addSubview(column2)
        column2.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3).offset(-spacing)
        }
        
        boardView.addSubview(column3)
        column3.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3).offset(-spacing/2)
        }
        
        addSubview(resetButton)
        resetButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(boardView.snp.bottom).offset(20)
        }
        
        addSubview(playerOneNameTextfield)
        playerOneNameTextfield.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(10)
        }
        
        addSubview(playerTwoNameTextfield)
        playerTwoNameTextfield.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(playerOneNameTextfield.snp.bottom).offset(10)
        }
        
        addSubview(playerOneSymbolTextfield)
        playerOneSymbolTextfield.snp.makeConstraints {
            $0.leading.equalTo(playerOneNameTextfield.snp.trailing).offset(10)
            $0.centerY.equalTo(playerOneNameTextfield.snp.centerY)
        }
        
        addSubview(playerTwoSymbolTextfield)
        playerTwoSymbolTextfield.snp.makeConstraints {
            $0.leading.equalTo(playerTwoNameTextfield.snp.trailing).offset(10)
            $0.centerY.equalTo(playerTwoNameTextfield.snp.centerY)
        }
    }
    
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


