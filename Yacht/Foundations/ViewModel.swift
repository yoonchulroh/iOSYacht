//
//  ViewModel.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation

enum GameMode {
    case home
    case singleplayer
    case multiplayer
}

class ViewModel: ObservableObject {
    
    @Published private(set) var gameMode: GameMode
    
    @Published private(set) var currentTurn: Int
    @Published private(set) var iterations: Int
    @Published private(set) var remainingRolls: Int
    @Published private(set) var gameOver: Bool
    
    @Published private(set) var dicePart: DiceField
    @Published private(set) var userMessage: String
    
    @Published private(set) var playerCount: Int
    @Published private(set) var playerNames: [String]
    @Published private(set) var isBot: [Bool]
    @Published private(set) var playerScores: [ScoreTable]
    
    @Published private(set) var botPlayer: BotPlayer?
    
    init() {
        gameMode = .home
        
        currentTurn = 1
        iterations = 1
        remainingRolls = 3
        gameOver = false
        
        dicePart = DiceField(5)
        userMessage = "Starting the game..."
        
        playerCount = 2
        self.playerNames = ["Player 1", "Player 2"]
        self.isBot = [false, false, false]
        playerScores = []
        
        playerScores.append(ScoreTable())
        playerScores.append(ScoreTable())
    }
    
    func setBotPlayer() {
        let botPlayerID = [1,2].randomElement()!
        if botPlayerID == 1 {
            self.isBot = [false, true, false]
            playerNames = ["Bot", "Player"]
        } else {
            self.isBot = [false, false, true]
            playerNames = ["Player", "Bot"]
        }
        
        self.botPlayer = BotPlayer(playerID: botPlayerID, viewModel: self)
        
        if isBot[currentTurn] {
            userMessage = self.botPlayer!.playTurn()
            passTurn()
        }
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
        }
    }
    
    func passTurn() {
        objectWillChange.send()
        dicePart.partialReset()
        remainingRolls = 3
        updateTurnNumber()
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
                userMessage = botPlayer!.playTurn()
                passTurn()
            }
        }
    }
    
    func updateTurnNumber() {
        currentTurn += 1
        if currentTurn > playerCount {
            iterations += 1
            currentTurn = 1
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
        setBotPlayer()
    }
}

