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
            print("DID SETTING")
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
    var segmentedControl: UISegmentedControl!
    var allowNameEditting = true
    
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
        gameViewModel.computerTurnDelegate = self
        
        backgroundColor = UIColor.white
        
        let items = ["2-Person", "Computer"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .allEvents)
        
        titleLabel.text = "Tic-Tac-Toe"
        
        resetButton.setTitle("Rage Quit 😡", for: .normal)
        resetButton.backgroundColor = UIColor.red
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        p1NameTextfield.text = store.playerOne.name
        p1NameTextfield.enablesReturnKeyAutomatically = true
        p1NameTextfield.delegate = self
        p2NameTextfield.text = store.playerTwo.name
        p1SymbolTextfield.enablesReturnKeyAutomatically = true
        p2NameTextfield.delegate = self
        
        p1SymbolTextfield.text = store.playerOne.symbol
        p1SymbolTextfield.enablesReturnKeyAutomatically = true
        p1SymbolTextfield.delegate = self
        p2SymbolTextfield.text = store.playerTwo.symbol
        p2SymbolTextfield.enablesReturnKeyAutomatically = true
        p2SymbolTextfield.delegate = self
        
        p1WinsLabel.text = "Wins: \(store.playerOne.wins)"
        p2WinsLabel.text = "Wins: \(store.playerTwo.wins)"
        
        generateBoard()
        
    }
    
    func generateBoard() {
        let columnArray = [column1, column2, column3]
        
        var number = 1
        var columnNum = 1
        for column in columnArray {
            
            column.axis = .vertical
            column.spacing = spacing
            column.distribution = .fillEqually
            
            var rowNum = 1
            for _ in 1...3 {
                
                let button = GameSquareButton(column: columnNum, row: rowNum, number: number)
                button.layer.cornerRadius = 10
                button.addTarget(self, action: #selector(playerChoseSquare(_:)), for: .touchUpInside)
                column.addArrangedSubview(button)
                
                number += 1
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
        
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(resetButton.snp.bottom).offset(20)
        }
    }
}

// MARK: General set-up methods
extension GameView {
    
    func resetTicTacToeBoard() {
        segmentedControl.isHidden = false
        enableTextField(true)
        allowNameEditting = true
        let columnArray = [column1, column2, column3]
        
        for column in columnArray {
            for squareButton in column.arrangedSubviews {
                if let squareButton = squareButton as? GameSquareButton {
                    squareButton.backgroundColor = UIColor().generateRandomColor()
                    if squareButton.square.player != nil {
                        squareButton.square.player = nil
                        squareButton.setTitle("", for: .normal)
                    }
                }
            }
        }
    }
    
    func segmentedControlChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            gameViewModel.isComputerPlaying = true
            p2NameTextfield.text = store.computer.name
            p2SymbolTextfield.text = store.computer.symbol
            p2WinsLabel.text = "Wins: \(store.computer.wins)"
            p2NameTextfield.allowsEditingTextAttributes = false
            p2SymbolTextfield.allowsEditingTextAttributes = false
        case 0:
            gameViewModel.isComputerPlaying = false
            p2NameTextfield.text = store.playerTwo.name
            p2SymbolTextfield.text = store.playerTwo.symbol
            p2WinsLabel.text =  "Wins: \(store.playerTwo.wins)"
            p2NameTextfield.allowsEditingTextAttributes = true
            p2SymbolTextfield.allowsEditingTextAttributes = true
        default:
            break
        }
    }
    
    func enableTextField(_ allows:Bool) {
        p1NameTextfield.allowsEditingTextAttributes = allows
        p1SymbolTextfield.allowsEditingTextAttributes = allows
        p2SymbolTextfield.allowsEditingTextAttributes = allows
        p2NameTextfield.allowsEditingTextAttributes = allows
    }
    
}

// Game Interface Methods
extension GameView: ComputerTurnDelegate {
    
    func playerChoseSquare(_ sender: UIButton) {
        segmentedControl.isHidden = true
        enableTextField(false)
        allowNameEditting = false
        gameViewModel.squareSelected(at: sender)
    }
    
    func computerChoseSquare(at coordinate: Coordinate) {
        segmentedControl.isHidden = true
        let columnArray = [column1, column2, column3]
        
        let column = coordinate.column - 1
        let row = coordinate.row - 1
        
        if let selectedButton = columnArray[column].arrangedSubviews[row] as? GameSquareButton {
            gameViewModel.squareSelected(at: selectedButton)
        }
    }
    
    func resetButtonPressed() {
        resetTicTacToeBoard()
        gameViewModel.resetGame()
        p1WinsLabel.text = "\(store.playerOne.wins)"
        if segmentedControl.selectedSegmentIndex == 1 {
            p2WinsLabel.text = "\(store.computer.wins)"
        } else {
            p1WinsLabel.text = "\(store.playerTwo.wins)"
        }
    }
}

// User name and symbol updates
extension GameView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return allowNameEditting
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == p1NameTextfield && textField.text != "" {
            store.playerOne.name = textField.text!
        } else if textField == p1SymbolTextfield && textField.text != ""  {
            store.playerOne.symbol = textField.text!
        } else if textField == p2NameTextfield && textField.text != ""  {
            store.playerTwo.name = textField.text!
        } else if textField == p2SymbolTextfield && textField.text != ""  {
            store.playerTwo.symbol = textField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == p1NameTextfield && textField.text != "" {
            store.playerOne.name = textField.text!
        } else if textField == p1SymbolTextfield && textField.text != ""  {
            store.playerOne.symbol = textField.text!
        } else if textField == p2NameTextfield && textField.text != ""  {
            store.playerTwo.name = textField.text!
        } else if textField == p2SymbolTextfield && textField.text != ""  {
            store.playerTwo.symbol = textField.text!
        }
    }
    
    
}

