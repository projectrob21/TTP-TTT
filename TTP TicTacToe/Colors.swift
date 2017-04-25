//
//  Colors.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public static let backgroundDark = UIColor(red: 42/255, green: 222/255, blue: 199/255, alpha: 1)
    
    public static let backgroundLight = UIColor(red: 255/255, green: 255/255, blue: 166/255, alpha: 1)
    
    public static let themeCoral = UIColor(red: 242 / 255, green: 100 / 255, blue: 80 / 255, alpha: 1)

    
    func generateRandomColor() -> UIColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        
        return color
    }
}

extension CAGradientLayer {
    convenience init(_ colors: [UIColor]) {
        self.init()
        
        self.colors = colors.map { $0.cgColor }
    }
}

extension CALayer {
    
    public static func makeGradient(firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
        let backgroundGradient = CAGradientLayer()
        
        backgroundGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        backgroundGradient.locations = [0, 1]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 0, y: 1)
        
        return backgroundGradient
    }
}
