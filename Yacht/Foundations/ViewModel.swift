//
//  ViewModel.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private(set) var dicePart: DiceField
    @Published private(set) var playerScores: [ScoreTable]
    @Published private(set) var isBot: [Bool]
    @Published private(set) var remainingRolls: Int
    @Published private(set) var currentTurn: Int
    @Published private(set) var userMessage: String
    @Published private(set) var botPlayer: BotPlayer?
    
    init() {
        dicePart = DiceField(5)
        playerScores = []
        isBot = [false, true]
        remainingRolls = 3
        currentTurn = 1
        userMessage = "Starting the game..."
        playerScores.append(ScoreTable())
        playerScores.append(ScoreTable())
    }
    
    func setBotPlayer(botPlayer: BotPlayer) {
        self.botPlayer = botPlayer
    }
    
    func roll() {
        objectWillChange.send()
        if remainingRolls > 0 {
            dicePart.rollDices()
            if dicePart.checkUserMessage() != "" {
                userMessage = dicePart.checkUserMessage()
            } else {
                userMessage = "It is now Player " + String(currentTurn) + "'s turn."
            }
            remainingRolls -= 1
        }
    }
    
    func lockToggle(_ diceIndex: Int) {
        objectWillChange.send()
        dicePart.dices[diceIndex].locked.toggle()
    }
    
    func addToScore(_ scoreType: String, _ playerID: Int) {
        objectWillChange.send()
        if !playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!] {
            playerScores[playerID - 1].score[scoreTypeDictionary[scoreType]!] = dicePart.calculateScore(scoreType)
            playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!] = true
            playerScores[playerID - 1].calculateSecondaryScore(scoreType, dicePart)
            passTurn()
        }
    }
    
    func passTurn() {
        objectWillChange.send()
        dicePart.reset()
        remainingRolls = 3
        currentTurn = 3 - currentTurn
        userMessage = "It is now Player " + String(currentTurn) + "'s turn."
        if isBot[currentTurn - 1] {
            botPlayer!.playTurn()
        }
    }
    
    func resetScore() {
        objectWillChange.send()
        for item in playerScores {
            item.resetScore()
        }
    }
}

