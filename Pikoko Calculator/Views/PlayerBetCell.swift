//
//  PlayerBetCell.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 26/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class PlayerBetCell: UITableViewCell {

    
    @IBOutlet weak var playerImage: PlayerImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerBetsTextField: UITextField!
    
    
    override func awakeFromNib() {
        playerBetsTextField.keyboardType = .numberPad
        self.selectionStyle = .none
    }
    
}


