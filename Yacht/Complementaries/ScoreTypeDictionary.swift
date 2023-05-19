//
//  ScoreTypeDictionary.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/19.
//

import Foundation

var scoreTypeDictionary: [String: Int] = [
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "bonus": 0,
    
    "choice": 7,
    "fullHouse": 8,
    "fourOfKind": 9,
    "smallStraight": 10,
    "largeStraight": 11,
    "yacht": 12
]

var reversedScoreTypeDictionary: [Int: String] = [
    1: "1",
    2: "2",
    3: "3",
    4: "4",
    5: "5",
    6: "6",
    0: "bonus",
    
    7: "choice",
    8: "fullHouse",
    9: "fourOfKind",
    10: "smallStraight",
    11: "largeStraight",
    12: "yacht"
]
