//
//  ScoreCalculator.swift
//  Pikoko Calculator
//
//  Created by Mihails Kuznecovs on 28/12/2019.
//  Copyright © 2019 Mihails Kuznecovs. All rights reserved.
//

import Foundation


class ScoreCalculator {
    
    static func calculateScore(for allPlayers: [Player]) {
        for player in allPlayers {
            for bet in player.playerBets {
                if bet.bet == bet.player.playsTaken {
                    player.score += 2
                }
                else if bet.bet == bet.player.playsTaken - 1 || bet.bet == bet.player.playsTaken + 1 {
                    player.score += 1
                }
            }
            calculateConfidenceCards(for: player)
        }
        updateBetsAndPlays(for: allPlayers)
    }
    
    static func calculateConfidenceCards(for player: Player) {
        guard let confidenceCard = player.confidenceCard, confidenceCard != .clear else { player.score += 1; return }
        
        for bet in player.playerBets {
            if confidenceCard == bet.player.color {
                if bet.bet == bet.player.playsTaken {
                    player.score += 3
                }
                else {
                    player.score -= 1
                }
            }
        }
    }
    
    static func updateBetsAndPlays(for allPlayers: [Player]) {
        for player in allPlayers {
            player.playerBets.removeAll()
            player.confidenceCard = nil
            player.playsTaken = 0
            
            GameState.playsTaken = false
            GameState.betsPlaced = false
            GameState.confidenceCardsPlaced = false
        }
    }
}
