//
//  TableViewCell.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 15/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit



class EnterPlayerCell: UITableViewCell {

    @IBOutlet weak var playerColor: PlayerImageView!
    @IBOutlet weak var playerNameText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
