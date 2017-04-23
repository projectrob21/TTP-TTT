//
//  ViewController.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var gameView: GameView!
    
    let playerOne = Player(name: "Player One", symbol: "❌")
    let playerTwo = Player(name: "Player Two", symbol: "⭕️")

    var currentTurn: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    
        
        currentTurn = playerOne
        
        
        gameView = GameView()
        view.addSubview(gameView)
        gameView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(gameView.snp.width)
        }
    }

    func turnTaken() {
        if currentTurn == playerOne {
            currentTurn = playerTwo

        } else {
            currentTurn = playerOne
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

