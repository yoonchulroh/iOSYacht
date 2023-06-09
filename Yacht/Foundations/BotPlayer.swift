//
//  BotPlayer.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/19.
//

import Foundation

class BotPlayer: ObservableObject {
    var viewModel: ViewModel?
    var playerID: Int
    var lockActions: LockActions?
    var pickActions: PickActions?
    var checkPickAvailableActions: CheckPickAvailableActions?
    var priorities: PriorityList = PriorityList()
    var active: Bool = true
    
    var turnCaptured: Bool = false
    
    init(playerID: Int, viewModel: ViewModel) {
        self.playerID = playerID
        setViewModel(viewModel: viewModel)
    }
    
    func waitForTurn() {
        let interval: UInt32 = 80000
        
        DispatchQueue.global(qos: .userInteractive).async {
            while self.active {
                if self.viewModel!.currentTurn == self.playerID && !self.turnCaptured {
                    self.turnCaptured = true
                    DispatchQueue.main.async {
                        self.viewModel!.roll()
                    }
                    usleep(interval)
                    DispatchQueue.main.async {
                        self.playPhase(1)
                    }
                    usleep(interval)
                    DispatchQueue.main.async {
                        self.viewModel!.roll()
                    }
                    usleep(interval)
                    DispatchQueue.main.async {
                        self.playPhase(2)
                    }
                    usleep(interval)
                    DispatchQueue.main.async {
                        self.viewModel!.roll()
                    }
                    usleep(interval)
                    DispatchQueue.main.async {
                        self.playPhase(3)
                    }
                    usleep(interval)
                    DispatchQueue.main.async {
                        self.viewModel!.passTurn()
                    }
                    self.turnCaptured = false
                }
                usleep(interval*7)
            }
        }
    }
    
    func setViewModel(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.lockActions = LockActions(viewModel: viewModel)
        self.pickActions = PickActions(viewModel: viewModel, playerID: playerID)
        self.checkPickAvailableActions = CheckPickAvailableActions(viewModel: viewModel, playerID: playerID)
    }
    
    func playTurn() {
        self.viewModel!.roll()
        playPhase(1)
        self.viewModel!.roll()
        playPhase(2)
        self.viewModel!.roll()
        playPhase(3)
    }
    
    func playPhase(_ phase: Int) {
        var diceEvaluationList: [Bool] = []
        var availableIDs: [Int] = []
        var priorityForIDs: [Int] = []
        var topPriorityIDs: [Int] = []
        var topPriority: Int

        diceEvaluationList = DiceEvaluationList().toListConverter(evaluationTable: DiceEvaluationTable(diceData: viewModel!.dicePart))
        for i in 0 ... 398 {
            if diceEvaluationList[i] && checkPickAvailableActions!.checkPickAvailableByID(ID: i) {
                availableIDs.append(i)
            }
        }
        for item in availableIDs {
            priorityForIDs.append(priorities.phasePriorities[phase - 1][item])
        }
        
        topPriority = priorityForIDs[0]
        for i in 0 ... availableIDs.count - 1 {
            if priorityForIDs[i] > topPriority {
                topPriority = priorityForIDs[i]
                topPriorityIDs = []
                topPriorityIDs.append(availableIDs[i])
            } else if priorityForIDs[i] == topPriority {
                topPriority = priorityForIDs[i]
                topPriorityIDs.append(availableIDs[i])
            }
        }
        
        if phase < 3 {
            lockActions!.lockByID(ID: topPriorityIDs.randomElement()!)
        } else {
            let ID = topPriorityIDs.randomElement()!
            pickActions!.pickByID(ID: ID)
        }
    }
}
