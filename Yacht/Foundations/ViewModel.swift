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
    case settings
    case testLuck
}

class ViewModel: ObservableObject, NSCopying {
    
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
    @Published private(set) var secondBotPlayer: BotPlayer?
    
    @Published private(set) var simulatedWinCount: [Int] = []
    @Published private(set) var winProbabilityPredictor: WinProbabilityPredictor?
    @Published var newEvent: Bool
    
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
        
        simulatedWinCount = [0,0,0]
        newEvent = false
        
        playerScores.append(ScoreTable())
        playerScores.append(ScoreTable())
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copiedViewModel = ViewModel()
        
        copiedViewModel.gameMode = self.gameMode
        
        copiedViewModel.currentTurn = self.currentTurn
        copiedViewModel.iterations = self.iterations
        copiedViewModel.remainingRolls = self.remainingRolls
        copiedViewModel.gameOver = self.gameOver
        
        copiedViewModel.playerNames = self.playerNames
        copiedViewModel.isBot = self.isBot
        
        var tempPlayerScores: ScoreTable
        for item in self.playerScores {
            tempPlayerScores = item.copy() as! ScoreTable
            copiedViewModel.playerScores.append(tempPlayerScores)
        }
        
        copiedViewModel.botPlayer = BotPlayer(playerID: 1, viewModel: copiedViewModel)
        copiedViewModel.secondBotPlayer = BotPlayer(playerID: 2, viewModel: copiedViewModel)
        
        copiedViewModel.simulatedWinCount = self.simulatedWinCount
        
        return copiedViewModel
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
        
        /*
        if isBot[currentTurn] {
            self.botPlayer!.playTurn()
            passTurn()
        }
         */
        botPlayer!.waitForTurn()
    }
    
    func setWinProbabilityPredictor() {
        self.winProbabilityPredictor = WinProbabilityPredictor(viewModel: self)
        self.winProbabilityPredictor!.runInTheBackground()
    }
    
    func setBotPlayerAllForSimulation() {
        self.isBot = [false, true, true]
        
        self.botPlayer = BotPlayer(playerID: 1, viewModel: self)
        self.secondBotPlayer = BotPlayer(playerID: 2, viewModel: self)
    }
    
    func roll() {
        objectWillChange.send()
        if remainingRolls > 0 {
            dicePart.rollDices()
            if dicePart.checkUserMessage() != "" {
                userMessage = dicePart.checkUserMessage()
            } else {
                userMessage = "It is " + playerNames[currentTurn - 1] + "'s turn."
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
            
            playerScores[playerID - 1].lastPick = scoreTypeToPresentable[scoreType]!
            playerScores[playerID - 1].lastGainedScore = String(dicePart.calculateScore(scoreType))
            
            newEvent = true
        }
    }
    
    func passTurn() {
        objectWillChange.send()
        dicePart.partialReset()
        remainingRolls = 3
        userMessage = playerNames[currentTurn - 1] + " picked " + playerScores[currentTurn - 1].lastPick + ", gaining " + playerScores[currentTurn - 1].lastGainedScore
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
            //userMessage = "It is now " + playerNames[currentTurn - 1] + "'s turn."
            /*
            if isBot[currentTurn] {
                botPlayer!.playTurn()
                passTurn()
            }
             */
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
        if botPlayer != nil {
            botPlayer!.active = false
        }
        if winProbabilityPredictor != nil {
            winProbabilityPredictor!.active = false
        }
        if gameMode == .singleplayer {
            setBotPlayer()
        }
        setWinProbabilityPredictor()
    }
    
    func switchGameMode(destination: GameMode) {
        objectWillChange.send()
        switch(destination) {
        case(.home):
            self.gameMode = .home
            dicePart.reset()
            resetScore()
        case(.singleplayer):
            self.gameMode = .singleplayer
            dicePart.reset()
            resetScore()
        case(.multiplayer):
            self.gameMode = .multiplayer
            dicePart.reset()
            resetScore()
            
            self.playerNames = ["Player 1", "Player 2"]
            self.isBot = [false, false, false]
        case(.settings):
            self.gameMode = .settings
        case(.testLuck):
            self.gameMode = .testLuck
            dicePart.reset()
            resetScore()
        }
    }
    
    func updateSimulatedWinCount (playerID: Int) {
        objectWillChange.send()
        if playerID == -1 {
            self.simulatedWinCount = [0,0,0]
        } else {
            self.simulatedWinCount[playerID] += 1
        }
    }
}

