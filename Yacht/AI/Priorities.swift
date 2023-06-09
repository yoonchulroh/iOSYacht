//
//  PriorityTable.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/21.
//

import Foundation

class Phase12PriorityTable {
    var numberPriority: [[Int]] = [[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100]]
    
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
    
    var fourInKindPriority: [[Int]] = [[0,2,4,6,8,10],[0,4,8,12,16,20],[0,6,12,18,24,30],[0,8,16,24,32,40],[0,10,20,30,40,50],[0,12,24,36,48,60]]
    
    var smallStraightPriority: [[Int]] = [[0,0,10,40,60],[0,0,10,40,60],[0,0,10,40,60]]
    
    var largeStraightPriority: [[Int]] = [[0,0,10,50,70,90],[0,0,10,50,70,90]]
    
    var yachtPriority: [[Int]] = [[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100],[0,10,20,50,80,100]]
}

struct Phase3PriorityTable {
    var numberPriority: [[Int]] = [[30,30,30,30,30,30],[25,25,25,25,25,25],[0,10,20,40,60,80],[0,10,20,40,60,80],[0,10,20,40,60,80],[0,10,20,40,60,80]]
    
    var choicePriority: [[Int]] = [[0,0,0,0,15,20],[0,10,15,20,25,30],[0,10,15,30,35,40],[0,10,15,40,45,50]]
    
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
    
    var fourInKindPriority: [[Int]] = [[18,18,18,18,10,10],[18,18,18,18,20,20],[18,18,18,18,30,30],[18,18,18,18,40,40],[18,18,18,18,50,50],[18,18,18,18,60,60]]
    
    var smallStraightPriority: [[Int]] = [[10,10,10,10,60],[10,10,10,10,60],[10,10,10,10,60]]
    
    var largeStraightPriority: [[Int]] = [[15,15,15,15,15,80],[15,15,15,15,15,80]]
    
    var yachtPriority: [[Int]] = [[20,20,20,20,20,100],[20,20,20,20,20,100],[20,20,20,20,20,100],[20,20,20,20,20,100],[20,20,20,20,20,100],[20,20,20,20,20,100]]
}

class PriorityList {
    var phasePriorities: [[Int]] = [[],[],[]]
    
    init() {
        toListConverter12(priorityTable: Phase12PriorityTable(), phase: 1)
        toListConverter12(priorityTable: Phase12PriorityTable(), phase: 2)
        toListConverter3(priorityTable: Phase3PriorityTable(), phase: 3)
    }
    
    func toListConverter12(priorityTable: Phase12PriorityTable, phase: Int) {
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
    
    func toListConverter3(priorityTable: Phase3PriorityTable, phase: Int) {
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
