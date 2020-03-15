//
//  PlayerImageView.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 11/01/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class PlayerImageView: UIImageView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.borderWidth = 0.7
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
}
