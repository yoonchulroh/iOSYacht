//
//  ViewModel.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation

enum GameMode: Int {
    case home = 1
    case singleplayer = 2
    case multiplayer = 3
    case settings = 4
    case testLuck = 5
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
    @Published private(set) var secondBotPlayer: BotPlayer?
    
    @Published private(set) var simulatedWinCount: [Int] = []
    @Published private(set) var winProbabilityPredictor: WinProbabilityPredictor?
    @Published var newEvent: Bool
    
    var isInPredictor: Bool = false
    var mainViewModel: Bool
    
    init(mainViewModel: Bool = false) {
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
        self.mainViewModel = mainViewModel
        
        playerScores.append(ScoreTable())
        playerScores.append(ScoreTable())
    }
    
    func copy() -> ViewModel {
        let copiedViewModel = ViewModel()
        
        copiedViewModel.gameMode = self.gameMode
        
        copiedViewModel.currentTurn = self.currentTurn
        copiedViewModel.iterations = self.iterations
        copiedViewModel.remainingRolls = self.remainingRolls
        copiedViewModel.gameOver = self.gameOver
        
        copiedViewModel.playerNames = self.playerNames
        copiedViewModel.isBot = self.isBot
        
        copiedViewModel.playerScores[0] = self.playerScores[0].copy()
        copiedViewModel.playerScores[1] = self.playerScores[1].copy()
        
        copiedViewModel.botPlayer = BotPlayer(playerID: 1, viewModel: copiedViewModel)
        copiedViewModel.secondBotPlayer = BotPlayer(playerID: 2, viewModel: copiedViewModel)
        
        copiedViewModel.simulatedWinCount = self.simulatedWinCount
        
        return copiedViewModel
    }
    
    func saveCurrentGame() {
        UserDefaults.standard.set(true, forKey: "saveGameExists")
        
        UserDefaults.standard.set(self.gameMode.rawValue, forKey: "gameMode")
        
        UserDefaults.standard.set(self.iterations, forKey: "iterations")
        UserDefaults.standard.set(self.currentTurn, forKey: "currentTurn")
        UserDefaults.standard.set(self.remainingRolls, forKey: "remainingRolls")
        UserDefaults.standard.set(self.gameOver, forKey: "gameOver")
        
        var diceFaces: [Int] = []
        for dice in dicePart.dices {
            diceFaces.append(dice.diceFace)
        }
        UserDefaults.standard.set(diceFaces, forKey: "diceFaces")
        UserDefaults.standard.set(self.userMessage, forKey: "userMessage")
        
        UserDefaults.standard.set(self.playerCount, forKey: "playerCount")
        UserDefaults.standard.set(self.playerNames, forKey: "playerNames")
        UserDefaults.standard.set(self.isBot, forKey: "isBot")
        
        var playerScores: [[Int]] = []
        var playerScoresLocked: [[Bool]] = []
        var totalScores: [Int] = []
        for item in self.playerScores {
            playerScores.append(item.score)
            playerScoresLocked.append(item.scoreLocked)
            totalScores.append(item.totalScore)
        }
        UserDefaults.standard.set(playerScores, forKey: "playerScores")
        UserDefaults.standard.set(playerScoresLocked, forKey: "playerScoresLocked")
        UserDefaults.standard.set(totalScores, forKey: "totalScores")
    }
    
    func restoreGame() {
        if UserDefaults.standard.bool(forKey: "saveGameExists") {
            self.gameMode = GameMode(rawValue: UserDefaults.standard.integer(forKey: "gameMode")) ?? GameMode(rawValue: 1)!
            
            self.iterations = UserDefaults.standard.integer(forKey: "iterations")
            self.currentTurn = UserDefaults.standard.integer(forKey: "currentTurn")
            self.remainingRolls = UserDefaults.standard.integer(forKey: "remainingRolls")
            self.gameOver = UserDefaults.standard.bool(forKey: "gameOver")
            
            for i in 0 ... 4 {
                self.dicePart.dices[i].diceFace = UserDefaults.standard.array(forKey: "diceFaces")![i] as! Int
            }
            self.userMessage = UserDefaults.standard.string(forKey: "userMessage") ?? "restore game error"
            self.playerNames = UserDefaults.standard.array(forKey: "playerNames")! as! [String]
            self.isBot = UserDefaults.standard.array(forKey: "isBot") as! [Bool]
            
            assert(self.playerCount == UserDefaults.standard.integer(forKey: "playerCount"))
            for i in 0 ... playerScores.count - 1 {
                self.playerScores[i].score = UserDefaults.standard.array(forKey: "playerScores")![i] as! [Int]
                self.playerScores[i].scoreLocked = UserDefaults.standard.array(forKey: "playerScoresLocked")![i] as! [Bool]
                self.playerScores[i].totalScore = UserDefaults.standard.array(forKey: "totalScores")![i] as! Int
                
            }
            
            if botPlayer != nil {
                botPlayer!.active = false
            }
            if winProbabilityPredictor != nil {
                winProbabilityPredictor!.active = false
            }
            
            for i in 1 ... playerCount {
                if isBot[i] {
                    self.botPlayer = BotPlayer(playerID: i, viewModel: self)
                    self.botPlayer!.waitForTurn()
                }
            }
            setWinProbabilityPredictor()
        }
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
        updateSimulatedWinCount(playerID: -1)
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
        if mainViewModel {
            saveCurrentGame()
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
            if decideWinner() > 0 {
                userMessage = playerNames[decideWinner() - 1] + " Wins!"
            } else {
                userMessage = "Draw!"
            }
            currentTurn = 0
        }
        newEvent = true
        if mainViewModel {
            saveCurrentGame()
        }
    }
    
    func updateTurnNumber() {
        currentTurn += 1
        if currentTurn > playerCount {
            iterations += 1
            currentTurn = 1
        }
    }
    
    func decideWinner() -> Int {
        var winner: [Int] = [1]
        for i in 2 ... playerCount {
            if playerScores[i - 1].totalScore > playerScores[winner[0] - 1].totalScore {
                winner = [i]
            } else if playerScores[i - 1].totalScore == playerScores[winner[0] - 1].totalScore {
                winner.append(i)
            }
        }
        if winner.count > 1 {
            return 0
        } else {
            return winner[0]
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
    
    func switchGameMode(destination: GameMode, loadPreviousGame: Bool = false) {
        objectWillChange.send()
        switch(destination) {
        case(.home):
            self.gameMode = .home
            dicePart.reset()
            resetScore()
        case(.singleplayer):
            self.gameMode = .singleplayer
            if loadPreviousGame {
                restoreGame()
            } else {
                dicePart.reset()
                resetScore()
            }
        case(.multiplayer):
            self.gameMode = .multiplayer
            if loadPreviousGame {
                restoreGame()
            } else {
                dicePart.reset()
                resetScore()
            }
            
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

