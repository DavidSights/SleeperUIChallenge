//
//  Constants.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/9/24.
//

import UIKit

struct Constants {

    enum Color {
        case lighterPurple
        case lightPurple
        case darkPurple
        case darkerPurple
        case darkGreen

        var value: UIColor {
            switch self {
            case .lighterPurple:
                return UIColor(red: 242/255, green: 237/255, blue: 255/255, alpha: 1)
            case .lightPurple:
                return UIColor(red: 215/255,
                               green: 178/225,
                               blue: 250/255,
                               alpha: 1)
            case .darkPurple:
                return UIColor(red: 146/225, 
                               green: 125/255,
                               blue: 165/255,
                               alpha: 1)
            case .darkerPurple:
                return UIColor(red: 93/225,
                               green: 48/255,
                               blue: 128/255,
                               alpha: 1)
            case .darkGreen:
                return UIColor(red: 0/255, 
                               green: 143/255,
                               blue: 86/255,
                               alpha: 1)
            }
        }
    }

    enum Size: CGFloat {
        case primaryButtonCornerRadius = 3
    }
}
