//
//  ConfidenceCardVC.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 02/01/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit



class ConfidenceCardVC: UIViewController, UITextFieldDelegate {
    
    var allPlayers: [Player] = []
    var delegate: PlayersDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func createConfidenceCards() {
        guard let cells = tableView.visibleCells as? [ConfidenceCardCell] else { return }
        var confidenceCards = [UIColor]()
        for cell in cells {
            let pickedCard = cell.pickedConfidenceCard ?? ConfidenceCards.noConfidence
            switch pickedCard {
            case .noConfidence:
                confidenceCards.append(.clear)
            case .confidenceRed:
                confidenceCards.append(PlayerColors.colors[0])
            case .confidenceBlue:
                confidenceCards.append(PlayerColors.colors[1])
            case .confidenceYellow:
                confidenceCards.append(PlayerColors.colors[2])
            case .confidencePurple:
                confidenceCards.append(PlayerColors.colors[3])
            case .confidenceWhite:
                confidenceCards.append(PlayerColors.colors[4])
            }
        }
        placeConfidenceCards(confidenceCards)
    }
    
    private func placeConfidenceCards(_ cards: [UIColor]) {
        let playersCount = allPlayers.count
        for n in 0..<playersCount {
            allPlayers[n].confidenceCard = cards[n]
        }
        GameState.confidenceCardsPlaced = true
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        createConfidenceCards()
        delegate?.updateVC()
        dismiss(animated: true, completion: nil)
    }
}

extension ConfidenceCardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfidenceCardCell", for: indexPath) as! ConfidenceCardCell
        cell.playerBetsTextField.delegate = self
        
        let player = allPlayers[indexPath.row]
        
        cell.playerImage.backgroundColor = player.color
        cell.playerNameLabel.text = player.name
        return cell
    }
}
