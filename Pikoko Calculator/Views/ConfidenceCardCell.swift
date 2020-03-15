//
//  ConfidenceCardCell.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 04/01/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit



class ConfidenceCardCell: PlayerBetCell, ConfidenceCardPickerDelegate {
    
    var pickedConfidenceCard: ConfidenceCards? {
        didSet {
            playerBetsTextField.text = pickedConfidenceCard?.rawValue
        }
    }
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        
        let ccPicker = ConfidenceCardPicker()
        ccPicker.ccDelelegate = self
        playerBetsTextField.inputView = ccPicker
    }
}
