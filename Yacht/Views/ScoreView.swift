//
//  ScoreView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI
import Foundation

struct ScoreView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            ScoreTableLeftLegend()
            playerScoreColumn(viewModel: viewModel, playerID: 1)
            playerScoreColumn(viewModel: viewModel, playerID: 2)
        }
        .padding(.all)
    }
}

struct ScoreTableLeftLegend: View {
    var body: some View {
        VStack {
            VStack {
                ForEach(["Score Type", "1", "2", "3", "4"], id: \.self) { label in
                    ScoreTableGrid(gridContent: label)
                }
            }
            
            VStack {
                ForEach(["5", "6", "Bonus", "Choice", "Full House"], id: \.self) { label in
                    ScoreTableGrid(gridContent: label)
                }
            }
                
            VStack {
                ForEach(["Four of Kind", "S. Straight", "L. Straight", "Yacht", "Total"], id: \.self) { label in
                    ScoreTableGrid(gridContent: label)
                }
            }
        }
    }
}

struct playerScoreColumn: View {
    @ObservedObject var viewModel: ViewModel
    var playerID: Int
    
    var body: some View {
        VStack {
            VStack {
                ScoreTableGrid(gridContent: "Player " + String(playerID))
                
                ForEach(["1","2","3","4"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
            }
            
            VStack {
                ForEach(["5", "6"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
                
                ScoreTableGrid(gridContent: String(viewModel.playerScores[playerID - 1].score[scoreTypeDictionary["bonus"]!]))
                
                ForEach(["choice", "fullHouse"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
            }
                
            VStack {
                ForEach(["fourOfKind", "smallStraight", "largeStraight", "yacht"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
                
                ScoreTableGrid(gridContent: String(viewModel.playerScores[playerID - 1].totalScore))
            }
        }
    }
}

struct ScoreTableGrid: View {
    var gridContent: String
    var shape = Rectangle()
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 3).foregroundColor(.blue)
            Text(gridContent)
                .foregroundColor(.black)
        }
    }
}

struct InteractiveScoreTableGrid: View {
    @ObservedObject var viewModel: ViewModel
    
    var playerID: Int
    var scoreType: String
    var gridContent: String
    var locked: Bool
    
    var shape = Rectangle()
    
    init(viewModel: ViewModel, playerID: Int, scoreType: String) {
        self.viewModel = viewModel
        self.playerID = playerID
        self.scoreType = scoreType
        self.locked = viewModel.playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!]
        if self.locked {
            self.gridContent = String(viewModel.playerScores[playerID - 1].score[scoreTypeDictionary[scoreType]!])
        } else if viewModel.currentTurn == playerID && viewModel.remainingRolls < 3 {
            self.gridContent = String(viewModel.dicePart.calculateScore(self.scoreType))
        } else {
            self.gridContent = "0"
        }
    }
    
    var body: some View {
        ZStack {
            if !locked {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3).foregroundColor(.blue)
                Text(gridContent).foregroundColor(.gray)
            } else {
                shape.fill().foregroundColor(.blue)
                shape.stroke(lineWidth: 3).foregroundColor(.white)
                Text(gridContent).foregroundColor(.white)
            }
        }
        .onTapGesture {
            if viewModel.currentTurn == playerID {
                viewModel.calculatePlayerScore(scoreType, playerID)
            }
        }
    }
}
