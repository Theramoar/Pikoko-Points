//
//  HomeVC.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 15/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, PlayersDelegate {
    
    var players: [Player] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        updateVC()
    }
    
    func updateVC() {
        if GameState.playsTaken {
             ScoreCalculator.calculateScore(for: players)
        }
        if GameState.playersEntered {
            addButton.isHidden = true
            addButton.isEnabled = false
            playButton.isHidden = false
            playButton.isEnabled = true
        }
        else {
            addButton.isHidden = false
            addButton.isEnabled = true
            playButton.isHidden = true
            playButton.isEnabled = false
        }
        
        updateButtonLabel()
        tableView.reloadData()
    }
    
    private func updateButtonLabel() {
        if !GameState.betsPlaced {
            playButton.setTitle("Place your bets", for: .normal)
        }
        else if !GameState.confidenceCardsPlaced {
            playButton.setTitle("Place Confidence Cards", for: .normal)
        }
        else {
            playButton.setTitle("Enter plays taken", for: .normal)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddPlayers", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "AddPlayers" :
            let vc = segue.destination as! EnterPlayerVC
            vc.delegate = self
        case "ShowBets" :
            let vc = segue.destination as! BetsVC
            vc.delegate = self
            vc.allPlayers = players
        case "ShowPlaysTaken" :
            let vc = segue.destination as! PlaysTakenVC
            vc.delegate = self
            vc.allPlayers = players
        case "ShowConfidence":
            let vc = segue.destination as! ConfidenceCardVC
            vc.delegate = self
            vc.allPlayers = players
        default:
            return
        }
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if !GameState.betsPlaced {
            performSegue(withIdentifier: "ShowBets", sender: self)
        }
        else if !GameState.confidenceCardsPlaced {
            performSegue(withIdentifier: "ShowConfidence", sender: self)
        }
        else {
            performSegue(withIdentifier: "ShowPlaysTaken", sender: self)
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        let player = players[indexPath.row]
        cell.playerColorImage.backgroundColor = player.color
        cell.playerNameLabel.text = player.name
        cell.playerScoreLabel.text = "Score: \(player.score)"
        return cell
    }
    
    
}
