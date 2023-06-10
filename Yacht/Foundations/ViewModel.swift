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
    @Published private(set) var iterations: Int
    @Published private(set) var userMessage: String
    @Published private(set) var botPlayer: BotPlayer?
    @Published private(set) var gameOver: Bool = false
    @Published private(set) var playerNames: [String]
    
    init() {
        dicePart = DiceField(5)
        playerScores = []
        iterations = 1
        isBot = [false, false, true]
        playerNames = ["Player", "Bot"]
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
                userMessage = "It is now " + playerNames[currentTurn - 1] + "'s turn."
            }
            remainingRolls -= 1
        }
    }
    
    func lockToggle(_ diceIndex: Int) {
        objectWillChange.send()
        if dicePart.dices[diceIndex].diceFace != 0 && remainingRolls < 3 {
            dicePart.dices[diceIndex].locked.toggle()
        }
    }
    
    func addToScore(_ scoreType: String, _ playerID: Int) {
        objectWillChange.send()
        if !playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!] && remainingRolls < 3 {
            playerScores[playerID - 1].score[scoreTypeDictionary[scoreType]!] = dicePart.calculateScore(scoreType)
            playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!] = true
            playerScores[playerID - 1].calculateSecondaryScore(scoreType, dicePart)
            passTurn()
        }
    }
    
    func passTurn() {
        objectWillChange.send()
        dicePart.partialReset()
        remainingRolls = 3
        currentTurn = 3 - currentTurn
        if currentTurn == 1 {
            iterations += 1
        }
        if iterations == 13 {
            gameOver = true
            dicePart.reset()
            if playerScores[0].totalScore > playerScores[1].totalScore {
                userMessage = playerNames[0] + " Wins!"
            } else if playerScores[1].totalScore > playerScores[0].totalScore {
                userMessage = playerNames[1] + " Wins!"
            } else {
                userMessage = "Draw!"
            }
            currentTurn = 0
        } else {
            userMessage = "It is now " + playerNames[currentTurn - 1] + "'s turn."
            if isBot[currentTurn] {
                botPlayer!.playTurn()
            }
        }
    }
    
    func resetScore() {
        objectWillChange.send()
        for item in playerScores {
            item.resetScore()
        }
        gameOver = false
        iterations = 1
        currentTurn = 1
        if remainingRolls < 3 {
            dicePart.reset()
        }
        remainingRolls = 3
        userMessage = "Starting the game..."
    }
}

