//
//  AlertViewProtocol.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/24/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

protocol AlertViewDelegate {
    
    func presentAlert(for winner: Player?)
    
}
