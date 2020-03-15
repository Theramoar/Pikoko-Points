//
//  BetsViewController.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 22/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class BetsVC: UIViewController, UITextFieldDelegate {

    var allPlayers: [Player] = []
    var usedPlayers: Int = 0
    var selectedPlayer: Player!
    var delegate: PlayersDelegate?
    var rivalBetsArePlaced: Bool = false

    
    @IBOutlet weak var selectedPlayerImageView: UIImageView!
    @IBOutlet weak var selectedPlayerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        selectedPlayerLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        selectedPlayerLabel.layer.shadowOpacity = 0.6
        selectedPlayerLabel.layer.shadowRadius = 1
    
        updatePlayersArray()
        updateSelectedPlayerImage()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func updatePlayersArray() {
        guard let player = allPlayers.first else { return }
        selectedPlayer = player
        allPlayers.append(player)
        allPlayers.removeFirst()
    }
    
    private func updateSelectedPlayerImage() {
        if rivalBetsArePlaced {
            selectedPlayerImageView.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            selectedPlayerLabel.text = "Yourself"
            return
        }
        selectedPlayerImageView.backgroundColor = selectedPlayer.color
        selectedPlayerLabel.text = selectedPlayer.name
        usedPlayers += 1
    }
    
    
    private func checkEnteredValues() -> [Int] {
        guard let cells = tableView.visibleCells as? [PlayerBetCell] else { return [] }
        var bets = [Int]()
        
        for cell in cells {
            guard let nameText = cell.playerBetsTextField.text, nameText != "" else { return [] }
            guard let bet = Int(nameText) else { return [] }
            bets.append(bet)
            cell.playerBetsTextField.text = ""
        }
        return bets
    }
    
    private func placeBets(_ bets: [Int]) {
        let playersCount = rivalBetsArePlaced ? allPlayers.count : allPlayers.dropLast().count
        for n in 0 ..< playersCount {
            guard let playerBetIsPutOn = rivalBetsArePlaced ? allPlayers[n] : selectedPlayer else { return }
            let playerBet = PlayerBet(player: playerBetIsPutOn, bet: bets[n])
            allPlayers[n].playerBets.append(playerBet)
        }
        GameState.betsPlaced = true
    }
    
    
    @IBAction func nextPlayerPressed(_ sender: Any) {
        let bets = checkEnteredValues()
        guard !bets.isEmpty else { print("Error Placing Bets"); return }
        placeBets(bets)
        
        if rivalBetsArePlaced {
            delegate?.updateVC()
            self.dismiss(animated: true, completion: nil)
        }
        else if allPlayers.count == usedPlayers {
            rivalBetsArePlaced = true
        }
        
        updatePlayersArray()
        updateSelectedPlayerImage()
        tableView.reloadData()
    }
}


extension BetsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rivalBetsArePlaced ? allPlayers.count : allPlayers.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerBetCell", for: indexPath) as! PlayerBetCell
        cell.playerBetsTextField.delegate = self
        let player = allPlayers[indexPath.row]

        cell.playerImage.backgroundColor = player.color
        cell.playerNameLabel.text = player.name
        return cell
    }
}
