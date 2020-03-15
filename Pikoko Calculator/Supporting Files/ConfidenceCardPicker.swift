//
//  ConfidenceCardPicker.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 04/01/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit


enum ConfidenceCards: String, CaseIterable {
    case noConfidence = "No Confidence (+1)"
    case confidenceRed = "Confidence Red (+3 / -1)"
    case confidenceBlue = "Confidence Blue (+3 / -1)"
    case confidenceYellow = "Confidence Yellow (+3 / -1)"
    case confidencePurple = "Confidence Purple (+3 / -1)"
    case confidenceWhite = "Confidence White (+3 / -1)"
}

protocol ConfidenceCardPickerDelegate {
    var pickedConfidenceCard: ConfidenceCards? { get set }
}

class ConfidenceCardPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    let confidenceCards = ConfidenceCards.allCases
    var ccDelelegate: ConfidenceCardPickerDelegate?
    var pickedConfidenceCard: ConfidenceCards? {
        didSet {
            ccDelelegate?.pickedConfidenceCard = pickedConfidenceCard
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
    }
    
//MARK: - UIPickerViewDataSource, UIPickerViewDelegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return confidenceCards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return confidenceCards[row].rawValue
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedConfidenceCard = confidenceCards[row]
    }
}
