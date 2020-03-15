//
//  ViewController.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 15/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import UIKit

protocol PlayersDelegate {
    var players: [Player] { get set }
    func updateVC()
}

class EnterPlayerVC: UIViewController, UITextFieldDelegate {

    var players: [Player] = []
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
    
    @IBAction func saveButtonPlaced(_ sender: Any) {
        fillPlayersArray()
        
        if !players.isEmpty, players.count != 1 {
            delegate?.players = players
            GameState.playersEntered = true
            delegate?.updateVC()
            self.dismiss(animated: true, completion: nil)
        }
        else {
            players.removeAll()
        }
    }
    
    func fillPlayersArray() {
        guard let cells = tableView.visibleCells as? [EnterPlayerCell] else { return }
        for cell in cells {
                if let nameText = cell.playerNameText.text, nameText != "" {
                    guard let color = cell.playerColor.backgroundColor else { return }
                    let player = Player(name: nameText, color: color)
                    players.append(player)
                }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension EnterPlayerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PlayerColors.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnterPlayerCell", for: indexPath) as! EnterPlayerCell
        cell.playerColor.backgroundColor = PlayerColors.colors[indexPath.row]
        cell.playerNameText.delegate = self
        return cell
    }
}

