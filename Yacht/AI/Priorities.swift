//
//  PriorityTable.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/21.
//

import Foundation

struct PriorityTable {
    var numberPriority: [[Int]] = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
    
    var choicePriority: [[Int]] = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
    
    var fullHousePriority: [[Int]] =
    [
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    ]
    //(1,2) (1,3) (1,4) (1,5) (1,6) (2,3) (2,4) (2,5) (2,6) (3,4) (3,5) (3,6) (4,5) (4,6) (5,6)
    
    var fourInKindPriority: [[Int]] = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
    
    var smallStraightPriority: [[Int]] = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
    
    var largeStraightPriority: [[Int]] = [[0,0,0,0,0,0],[0,0,0,0,0,0]]
    
    var yachtPriority: [[Int]] = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
}

class PriorityList {
    var phasePriorities: [[Int]] = [[],[],[]]
    
    init() {
        toListConverter(priorityTable: PriorityTable(), phase: 1)
        toListConverter(priorityTable: PriorityTable(), phase: 2)
        toListConverter(priorityTable: PriorityTable(), phase: 3)
    }
    
    func toListConverter(priorityTable: PriorityTable, phase: Int) {
        self.phasePriorities[phase - 1] = []
        for array in priorityTable.numberPriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
        for array in priorityTable.choicePriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
        for array in priorityTable.fullHousePriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
        for array in priorityTable.fourInKindPriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
        for array in priorityTable.smallStraightPriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
        for array in priorityTable.largeStraightPriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
        for array in priorityTable.yachtPriority {
            for item in array {
                phasePriorities[phase - 1].append(item)
            }
        }
    }
}
