//
//  ScoreViewController.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 28/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class PlaysTakenVC: UIViewController, UITextFieldDelegate {

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
    
    // Можно объединить с BetsVC в один СуперКласс
    private func checkEnteredValues() -> [Int] {
        guard let cells = tableView.visibleCells as? [PlayerBetCell] else { return [] }
        var bets = [Int]()
        
        for cell in cells {
            guard let nameText = cell.playerBetsTextField.text, nameText != "" else { return [] }
            guard let bet = Int(nameText) else { return [] }
            bets.append(bet)
        }
        return bets
    }
    
    private func placePlays(_ plays: [Int]) {
        let playersCount = allPlayers.count
        for n in 0..<playersCount {
            allPlayers[n].playsTaken = plays[n]
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        let plays = checkEnteredValues()
        guard !plays.isEmpty else { print("Error Entering Values"); return }
        placePlays(plays)
        GameState.playsTaken = true
        delegate?.updateVC()
        self.dismiss(animated: true, completion: nil)
    }
}

extension PlaysTakenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerBetCell", for: indexPath) as! PlayerBetCell
        cell.playerBetsTextField.delegate = self
        cell.playerBetsTextField.placeholder = "plays"
        
        let player = allPlayers[indexPath.row]
        
        cell.playerImage.backgroundColor = player.color
        cell.playerNameLabel.text = player.name
        return cell
    }
}
