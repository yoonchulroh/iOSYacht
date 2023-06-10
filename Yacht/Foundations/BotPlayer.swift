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
    
    init(playerID: Int, viewModel: ViewModel) {
        self.playerID = playerID
        setViewModel(viewModel: viewModel)
    }
    
    func setViewModel(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.lockActions = LockActions(viewModel: viewModel)
        self.pickActions = PickActions(viewModel: viewModel, playerID: playerID)
        self.checkPickAvailableActions = CheckPickAvailableActions(viewModel: viewModel, playerID: playerID)
    }
    
    func playTurn() -> String {
        var _ = playPhase(1)
        var _ = playPhase(2)
        return playPhase(3)
    }
    
    func playPhase(_ phase: Int) -> String {
        var diceEvaluationList: [Bool] = []
        var availableIDs: [Int] = []
        var priorityForIDs: [Int] = []
        var topPriorityIDs: [Int] = []
        var topPriority: Int
        
        viewModel!.roll()

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
            return "Non-pick Phase"
        } else {
            let ID = topPriorityIDs.randomElement()!
            pickActions!.pickByID(ID: ID)
            
            var botPickMessage = viewModel!.playerNames[playerID - 1]
            switch(ID) {
            case 0 ... 35:
                botPickMessage = botPickMessage + " picked Number " + String((ID + 6 - (ID % 6)) / 6) + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore(String((ID + 6 - (ID % 6)) / 6)))
            case 36 ... 59:
                botPickMessage = botPickMessage + " picked Choice" + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore("choice"))
            case 60 ... 299:
                botPickMessage = botPickMessage + " picked Full House" + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore("fullHouse"))
            case 300 ... 335:
                botPickMessage = botPickMessage + " picked Four of Kind" + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore("fourOfKind"))
            case 336 ... 350:
                botPickMessage = botPickMessage + " picked Small Straight" + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore("smallStraight"))
            case 351 ... 362:
                botPickMessage = botPickMessage + " picked Large Straight" + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore("largeStraight"))
            case 363 ... 398:
                botPickMessage = botPickMessage + " picked Yacht" + ", gaining "
                botPickMessage = botPickMessage + String(viewModel!.dicePart.calculateScore("yacht"))
            default:
                print("PlayPhase return String Error")
                botPickMessage = "PlayPhase return String Error"
            }
            return botPickMessage
        }
    }
}
