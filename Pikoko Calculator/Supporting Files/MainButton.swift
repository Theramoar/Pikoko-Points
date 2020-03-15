//
//  MainButton.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 09/01/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit


class MainButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = frame.size.height / 3
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        layer.cornerRadius = frame.size.height / 3
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
    }
}
