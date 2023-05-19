//
//  DiceData.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation

struct DiceData {
    var dices: Array<Dice> = []
    
    class Dice {
        let diceIndex: Int
        var diceFace: Int
        var locked: Bool
        
        init (_ diceIndex: Int) {
            self.diceIndex = diceIndex
            self.diceFace = 0
            self.locked = false
        }
        
        func roll() {
            diceFace = Int.random(in: 1 ... 6)
        }
        
        func reset() {
            diceFace = 0
            locked = false
        }
    }
    
    init(_ numberOfDices: Int) {
        for i in 1 ... numberOfDices {
            dices.append(Dice(i))
        }
    }
    
    func rollDices() {
        for i in 0 ... 4 {
            if !self.dices[i].locked {
                self.dices[i].roll()
            }
        }
    }
    
    func reset() {
        for dice in dices {
            dice.reset()
        }
    }
}
