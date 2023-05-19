//
//  CalculateScore.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import Foundation
/*
func calculateScore(scoreType: String, dicePart: DiceData) -> Int {
    var score: Int = 0
    var diceFaces: [Int] = [0,0,0,0,0,0]
    for i in 0 ... 4 {
        if dicePart.dices[i].diceFace > 0 {
            diceFaces[dicePart.dices[i].diceFace - 1] += 1
        }
    }
    switch scoreTypeDictionary[scoreType] ?? 0 {
    case 1...6:
        for i in 0 ... 4 {
            if dicePart.dices[i].diceFace == scoreTypeDictionary[scoreType] {
                score += scoreTypeDictionary[scoreType] ?? 0
            }
        }
    case 7:
        for i in 0 ... 4 {
            score += dicePart.dices[i].diceFace
        }
    case 8:
        var diceFaces: Array<Int> = [0,0,0,0,0,0]
        for i in 0 ... 4 {
            diceFaces[dicePart.dices[i].diceFace - 1] += 1
        }
        var tripleFound = -1
        var doubleFound = -1
        for i in 0 ... 5 {
            if diceFaces[i] == 3 {
                tripleFound = i
            }
            else if diceFaces[i] == 2 {
                doubleFound = i
            }
        }
        if (tripleFound > -1) && (doubleFound > -1) {
            score = (tripleFound + 1) * 3 + (doubleFound + 1) * 2
        }
    case 9:
        var fourInKind = false
        var scoreTotal = 0
        for i in 0 ... 5 {
            if diceFaces[i] > 3 {
                fourInKind = true
            }
            scoreTotal += diceFaces[i] * (i + 1)
        }
        if fourInKind {
            score = scoreTotal
        }
    case 10:
        var smallStraight1 = true
        var smallStraight2 = true
        var smallStraight3 = true
        for i in 0 ... 3 {
            if diceFaces[i] < 1 {
                smallStraight1 = false
            }
        }
        for i in 1 ... 4 {
            if diceFaces[i] < 1 {
                smallStraight2 = false
            }
        }
        for i in 2 ... 5 {
            if diceFaces[i] < 1 {
                smallStraight3 = false
            }
        }
        if smallStraight1 || smallStraight2 || smallStraight3 {
            score = 15
        }
    case 11:
        if diceFaces == [1,1,1,1,1,0] || diceFaces == [0,1,1,1,1,1] {
            score = 30
        }
    case 12:
        for item in diceFaces {
            if item == 5 {
                score = 50
            }
        }
    default:
        print("error")
    }
    return score
}
*/
