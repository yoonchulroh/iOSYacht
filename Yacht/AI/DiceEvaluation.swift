//
//  DiceEvaluation.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/21.
//

import Foundation

class DiceEvaluationTable {
    var numberEvaluation: [[Bool]] = []
    
    var choiceEvaluation: [[Bool]] = []
    
    var fullHouseEvaluation: [[Bool]] = []
    //(1,2) (1,3) (1,4) (1,5) (1,6) (2,3) (2,4) (2,5) (2,6) (3,4) (3,5) (3,6) (4,5) (4,6) (5,6)
    
    var fourInKindEvaluation: [[Bool]] = []
    
    var smallStraightEvaluation: [[Bool]] = []
    
    var largeStraightEvaluation: [[Bool]] = []
    
    var yachtEvaluation: [[Bool]] = []
    
    init(diceData: DiceField) {
        var numberStats: [Int] = [0,0,0,0,0,0,0]
        for item in diceData.dices {
            numberStats[item.diceFace] += 1
        }
        
        var aboveNumberStats: [Int] = [0,0,0,0,0,0,0]
        aboveNumberStats[6] = numberStats[6]
        for i in 2 ... 6 {
            aboveNumberStats[7 - i] = aboveNumberStats[8 - i] + numberStats[7 - i]
        }
        
        var cappedNumberStats: [Int] = numberStats
        for i in 1 ... 6 {
            if cappedNumberStats[i] > 3 {
                cappedNumberStats[i] = 3
            }
        }
        
        var smallStraightStats: [Int] = [0,0,0,0]
        var smallStraightNumberExists = 0
        for i in 1 ... 3 {
            smallStraightNumberExists = 0
            for j in 0 ... 3 {
                if numberStats[i + j] > 0 {
                    smallStraightNumberExists += 1
                }
            }
            smallStraightStats[i] = smallStraightNumberExists
        }
        
        var largeStraightStats: [Int] = [0,0,0]
        var largeStraightNumberExists = 0
        for i in 1 ... 2 {
            largeStraightNumberExists = 0
            for j in 0 ... 4 {
                if numberStats[i + j] > 0 {
                    largeStraightNumberExists += 1
                }
            }
            largeStraightStats[i] = largeStraightNumberExists
        }
        
        
        var evaluationArray: [Bool] = []
        for i in 1 ... 6 {
            evaluationArray = []
            for j in 0 ... 5 {
                if numberStats[i] == j {
                    evaluationArray.append(true)
                } else {
                    evaluationArray.append(false)
                }
            }
            numberEvaluation.append(evaluationArray)
            fourInKindEvaluation.append(evaluationArray)
            yachtEvaluation.append(evaluationArray)
        }
        
        for i in 3 ... 6 {
            evaluationArray = []
            for j in 0 ... 5 {
                if aboveNumberStats[i] == j {
                    evaluationArray.append(true)
                } else {
                    evaluationArray.append(false)
                }
            }
            choiceEvaluation.append(evaluationArray)
        }
        
        for i in 1 ... 5 {
            for j in (i + 1) ... 6 {
                evaluationArray = []
                for k in 0 ... 15 {
                    if numberStats[i] * 4 + numberStats[j] == k {
                        evaluationArray.append(true)
                    } else {
                        evaluationArray.append(false)
                    }
                }
                fullHouseEvaluation.append(evaluationArray)
            }
        }
        
        for i in 1 ... 3 {
            evaluationArray = []
            for j in 0 ... 4 {
                if smallStraightStats[i] == j {
                    evaluationArray.append(true)
                } else {
                    evaluationArray.append(false)
                }
            }
            smallStraightEvaluation.append(evaluationArray)
        }
        
        for i in 1 ... 2 {
            evaluationArray = []
            for j in 0 ... 5 {
                if largeStraightStats[i] == j {
                    evaluationArray.append(true)
                } else {
                    evaluationArray.append(false)
                }
            }
            largeStraightEvaluation.append(evaluationArray)
        }
    }
}

class DiceEvaluationList {
    var diceEvaluation: [Bool] = []
    
    func toListConverter(evaluationTable: DiceEvaluationTable) -> [Bool] {
        diceEvaluation = []
        for array in evaluationTable.numberEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        for array in evaluationTable.choiceEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        for array in evaluationTable.fullHouseEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        for array in evaluationTable.fourInKindEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        for array in evaluationTable.smallStraightEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        for array in evaluationTable.largeStraightEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        for array in evaluationTable.yachtEvaluation {
            for item in array {
                diceEvaluation.append(item)
            }
        }
        return diceEvaluation
    }
}
