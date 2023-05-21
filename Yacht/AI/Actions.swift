//
//  Strategies.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/21.
//

import Foundation

class LockActions {
    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func lockByID(ID: Int) {
        switch(ID) {
        case 0 ... 35:
            numberStrategy(number: (ID + 6 - (ID % 6)) / 6)
            break
        case 36 ... 59:
            choiceStrategy(lowerLimit: 3 + (ID - (ID % 6) - 36) / 6)
            break
        case 60 ... 299:
            var combination = 1 + (ID - ((ID - 60) % 16) - 60) / 16
            var first = 0
            var second = 0
            for i in 1 ... 5 {
                if combination > 6 - i {
                    combination -= 6 - i
                } else if combination > 0 {
                    first = i
                    second = i + combination
                    combination -= 6 - i
                }
            }
            fullHouseStrategy(first: first, second: second)
            break
        case 300 ... 335:
            fourInKindStrategy(number: 1 + (ID - (ID % 6) - 300) / 6)
            break
        case 336 ... 350:
            smallStraightStrategy(type: 1 + (ID - ((ID - 336) % 5) - 336) / 5)
            break
        case 351 ... 362:
            largeStraightStrategy(type: 1 + (ID - ((ID - 351) % 6) - 351) / 6)
            break
        case 363 ... 398:
            yachtStrategy(number: 1 + (ID - ((ID - 363) % 6) - 363) / 6)
            break
        default:
            print("lockByID Error")
        }
    }
    
    func numberStrategy(number: Int) {
        for item in viewModel.dicePart.dices {
            if item.diceFace == number {
                item.locked = true
            } else {
                item.locked = false
            }
        }
    }
    
    func choiceStrategy(lowerLimit: Int) {
        for item in viewModel.dicePart.dices {
            if item.diceFace >= lowerLimit {
                item.locked = true
            } else {
                item.locked = false
            }
        }
    }
    
    func fullHouseStrategy(first: Int, second: Int) {
        var firstCount: Int = 0
        var secondCount: Int = 0
        
        for item in viewModel.dicePart.dices {
            if item.diceFace == first && firstCount < 3 {
                firstCount += 1
                item.locked = true
            } else if item.diceFace == second && secondCount < 3 {
                secondCount += 1
                item.locked = true
            } else {
                item.locked = false
            }
        }
    }
    
    func fourInKindStrategy(number: Int) {
        for item in viewModel.dicePart.dices {
            if item.diceFace == number {
                item.locked = true
            } else {
                item.locked = false
            }
        }
    }
    
    func smallStraightStrategy(type: Int) {
        //type 1: 1,2,3,4 / type 2: 2,3,4,5 / type 3: 3,4,5,6
        var numberExists = [false, false, false, false]
        var position: Int
        
        for item in viewModel.dicePart.dices {
            position = item.diceFace - type
            if position <= 3 && position >= 0 {
                if !numberExists[position] {
                    item.locked = true
                    numberExists[position] = true
                } else {
                    item.locked = false
                }
            } else {
                item.locked = false
            }
        }
    }
    
    func largeStraightStrategy(type: Int) {
        var numberExists = [false, false, false, false, false]
        var position: Int
        
        for item in viewModel.dicePart.dices {
            position = item.diceFace - type
            if position <= 4 && position >= 0 {
                if !numberExists[position] {
                    item.locked = true
                    numberExists[position] = true
                } else {
                    item.locked = false
                }
            } else {
                item.locked = false
            }
        }
    }
    
    func yachtStrategy(number: Int) {
        for item in viewModel.dicePart.dices {
            if item.diceFace == number {
                item.locked = true
            } else {
                item.locked = false
            }
        }
    }
}

class PickActions {
    var viewModel: ViewModel
    var playerID: Int
    
    init(viewModel: ViewModel, playerID: Int) {
        self.viewModel = viewModel
        self.playerID = playerID
    }
    
    func pickByID(ID: Int) {
        switch(ID) {
        case 0 ... 35:
            numberPick(number: (ID + 6 - (ID % 6)) / 6)
            break
        case 36 ... 59:
            choicePick()
            break
        case 60 ... 299:
            fullHousePick()
            break
        case 300 ... 335:
            fourInKindPick()
            break
        case 336 ... 350:
            smallStraightPick()
            break
        case 351 ... 362:
            largeStraightPick()
            break
        case 363 ... 398:
            yachtPick()
            break
        default:
            print("pickByID Error")
        }
    }
    
    func numberPick(number: Int) {
        viewModel.addToScore(String(number), playerID)
    }
    
    func choicePick() {
        viewModel.addToScore("choice", playerID)
    }
    
    func fullHousePick() {
        viewModel.addToScore("fullHouse", playerID)
    }
    
    func fourInKindPick() {
        viewModel.addToScore("fourOfKind", playerID)
    }
    
    func smallStraightPick() {
        viewModel.addToScore("smallStraight", playerID)
    }
    
    func largeStraightPick() {
        viewModel.addToScore("largeStraight", playerID)
    }
    
    func yachtPick() {
        viewModel.addToScore("yacht", playerID)
    }
}

class CheckPickAvailableActions {
    var viewModel: ViewModel
    var playerID: Int
    
    init(viewModel: ViewModel, playerID: Int) {
        self.viewModel = viewModel
        self.playerID = playerID
    }
    
    func checkPickAvailableByID(ID: Int) -> Bool {
        switch(ID) {
        case 0 ... 35:
            return viewModel.playerScores[playerID - 1].checkPickAvailable(String((ID + 6 - (ID % 6)) / 6))
        case 36 ... 59:
            return viewModel.playerScores[playerID - 1].checkPickAvailable("choice")
        case 60 ... 299:
            return viewModel.playerScores[playerID - 1].checkPickAvailable("fullHouse")
        case 300 ... 335:
            return viewModel.playerScores[playerID - 1].checkPickAvailable("fourOfKind")
        case 336 ... 350:
            return viewModel.playerScores[playerID - 1].checkPickAvailable("smallStraight")
        case 351 ... 362:
            return viewModel.playerScores[playerID - 1].checkPickAvailable("largeStraight")
        case 363 ... 398:
            return viewModel.playerScores[playerID - 1].checkPickAvailable("yacht")
        default:
            print("pickByID Error")
            return false
        }
    }
}
