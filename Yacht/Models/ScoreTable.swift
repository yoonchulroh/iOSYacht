//
//  ScoreTable.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation

class ScoreTable {
    var score: [Int] = []
    var scoreLocked: [Bool] = []
    
    var lastPick: String = ""
    var lastGainedScore: String = ""
    
    var totalScore = 0
    
    init() {
        for _ in 1 ... 13 {
            score.append(0)
            scoreLocked.append(false)
        }
    }
    
    func copy() -> ScoreTable {
        let copiedScoreTable = ScoreTable()
        
        copiedScoreTable.score = self.score
        copiedScoreTable.scoreLocked = self.scoreLocked
        
        copiedScoreTable.lastPick = self.lastPick
        copiedScoreTable.lastGainedScore = self.lastGainedScore
        
        copiedScoreTable.totalScore = self.totalScore
        
        return copiedScoreTable
    }
    
    func calculateSecondaryScore(_ scoreType: String, _ dicePart: DiceField) {
        var numberScoreTotal = 0
        var numberScoreAllLocked = true
        for i in 1 ... 6 {
            numberScoreTotal += self.score[i]
            if self.scoreLocked[i] == false {
                numberScoreAllLocked = false
            }
        }
        if !self.scoreLocked[scoreTypeDictionary["bonus"] ?? 0] && numberScoreTotal >= 63 {
            self.score[scoreTypeDictionary["bonus"] ?? 0] = 35
            self.scoreLocked[scoreTypeDictionary["bonus"] ?? 0] = true
        } else if numberScoreAllLocked {
            self.scoreLocked[scoreTypeDictionary["bonus"] ?? 0] = true
        }
        
        self.calculateTotalScore()
    }
    
    func checkPickAvailable(_ scoreType: String) -> Bool {
        if scoreLocked[scoreTypeDictionary[scoreType]!] {
            return false
        } else {
            return true
        }
    }
    
    func calculateTotalScore() {
        totalScore = 0
        for item in score {
            totalScore += item
        }
    }
    
    func resetScore() {
        for i in 0 ... 12 {
            score[i] = 0
            scoreLocked[i] = false
        }
        totalScore = 0
        
        lastPick = ""
        lastGainedScore = ""
    }
}
