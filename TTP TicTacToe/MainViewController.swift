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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configure() {
        gameView = GameView()
        view.addSubview(gameView)
        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        gameView.resetButton.addTarget(self, action: #selector(resetFromVC), for: .touchUpInside)
    }

    func resetFromVC() {
        print("VC reset pressed")
        gameView.gameViewModel.resetGame()
        gameView.removeFromSuperview()
        gameView = nil
        
        configure()
        
    }
    
}

