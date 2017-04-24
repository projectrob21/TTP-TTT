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
    
    // Data Objects
    let store = DataStore.shared
    let gameViewModel = GameViewModel()
    
    // TTT Board Objects
    let boardView = UIView()
    var column1 = UIStackView()
    var column2 = UIStackView()
    var column3 = UIStackView()
    
    let spacing: CGFloat = 5.0
    
    // Player Information Objects
    // TODO fix textfields
    var p1NameTextfield = UITextField() {
        didSet {
            store.playerOne.name = p1NameTextfield.text!
        }
    }
    var p2NameTextfield = UITextField() {
        didSet {
            store.playerTwo.name = p2NameTextfield.text!
        }
    }
    var p1SymbolTextfield = UITextField()
    var p2SymbolTextfield = UITextField()
    
    var p1WinsLabel = UILabel()
    var p2WinsLabel = UILabel()
    
    
    // Other Objects
    let resetButton = UIButton()
    let titleLabel = UILabel()
    
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
        
        titleLabel.text = "Tic-Tac-Toe"
        
        resetButton.setTitle("Rage Quit 😡", for: .normal)
        resetButton.backgroundColor = UIColor.red
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        p1NameTextfield.placeholder = store.playerOne.name
        p2NameTextfield.placeholder = store.playerTwo.name
        
        p1SymbolTextfield.placeholder = store.playerOne.symbol
        p2SymbolTextfield.placeholder = store.playerTwo.symbol
        
        p1WinsLabel.text = "Wins: \(store.playerOne.wins)"
        p2WinsLabel.text = "Wins: \(store.playerTwo.wins)"
        
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10 + (UIApplication.shared.statusBarFrame.height))
        }
        
        addSubview(p1NameTextfield)
        p1NameTextfield.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        addSubview(p2NameTextfield)
        p2NameTextfield.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(p1NameTextfield.snp.bottom).offset(10)
        }
        
        addSubview(p1SymbolTextfield)
        p1SymbolTextfield.snp.makeConstraints {
            $0.leading.equalTo(p1NameTextfield.snp.trailing).offset(10)
            $0.centerY.equalTo(p1NameTextfield.snp.centerY)
        }
        
        addSubview(p2SymbolTextfield)
        p2SymbolTextfield.snp.makeConstraints {
            $0.leading.equalTo(p2NameTextfield.snp.trailing).offset(10)
            $0.centerY.equalTo(p2NameTextfield.snp.centerY)
        }
        
        addSubview(p1WinsLabel)
        p1WinsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(p1SymbolTextfield.snp.centerY)
        }
        
        addSubview(p2WinsLabel)
        p2WinsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(p2SymbolTextfield.snp.centerY)
        }
        
        addSubview(boardView)
        boardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(p2NameTextfield.snp.bottom).offset(25)
            $0.width.equalToSuperview().multipliedBy(0.9)
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


