//
//  ViewModel.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private(set) var dicePart: DiceData
    @Published private(set) var playerScores: [ScoreTable]
    @Published private(set) var remainingRolls: Int
    @Published private(set) var currentTurn: Int
    
    init() {
        dicePart = DiceData(5)
        playerScores = []
        remainingRolls = 3
        currentTurn = 1
        playerScores.append(ScoreTable())
        playerScores.append(ScoreTable())
    }
    
    func roll() {
        objectWillChange.send()
        if remainingRolls > 0 {
            dicePart.rollDices()
            remainingRolls -= 1
        }
    }
    
    func lockToggle(_ diceIndex: Int) {
        objectWillChange.send()
        dicePart.dices[diceIndex].locked.toggle()
    }
    
    func calculatePlayerScore(_ scoreType: String, _ playerID: Int) {
        objectWillChange.send()
        playerScores[playerID - 1].calculateScore(scoreType, dicePart)
        dicePart.reset()
        remainingRolls = 3
        currentTurn = 3 - currentTurn
    }
    
    func resetScore() {
        objectWillChange.send()
        for item in playerScores {
            item.resetScore()
        }
    }
}

