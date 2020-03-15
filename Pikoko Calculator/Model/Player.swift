//
//  Player.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 15/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit


struct PlayerColors {  
    static let colors: [UIColor] = [#colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
}

struct PlayerBet {
    let player: Player
    let bet: Int
}

class Player {
    var name = ""
    var color: UIColor
    var score = 0
    var playerBets = [PlayerBet]()
    var confidenceCard: UIColor?
    var playsTaken = 0
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
