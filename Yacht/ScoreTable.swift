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
    
    init() {
        for _ in 1 ... 13 {
            score.append(0)
            scoreLocked.append(false)
        }
    }
    
    var totalScore = 0
    
    func calculateScore(_ scoreType: String, _ dicePart: DiceData) {
        self.score[scoreTypeDictionary[scoreType]!] = Yacht.calculateScore(scoreType: scoreType, dicePart: dicePart)
        self.scoreLocked[scoreTypeDictionary[scoreType]!] = true
        var numberScoreTotal = 0
        for i in 1 ... 6 {
            numberScoreTotal += self.score[i]
        }
        if !self.scoreLocked[scoreTypeDictionary["bonus"] ?? 0] && numberScoreTotal >= 63 {
            self.score[scoreTypeDictionary["bonus"] ?? 0] = 35
            self.scoreLocked[scoreTypeDictionary["bonus"] ?? 0] = true
        }
        
        self.calculateTotalScore()
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
    }
}
