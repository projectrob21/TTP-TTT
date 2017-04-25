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

    func configure() {
        gameView = GameView()
        gameView.gameViewModel.alertViewDelegate = self
        
        view.addSubview(gameView)
        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MainViewController: AlertViewDelegate {
    
    func presentAlert(for winner: Player?) {

        if winner != nil {
            let alertController = UIAlertController(
                title: "We have a winner!!!",
                message: "\(winner!.name)",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)

        } else {
            let alertController = UIAlertController(
                title: "This games going to overtime!",
                message: "What a close game!",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)

        }
    }
    
}

