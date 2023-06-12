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
                ForEach(["5", "6", "Bonus (63+)", "Choice", "Full House"], id: \.self) { label in
                    HighlightedScoreTableGrid(gridContent: label, highlighted: label == "Bonus (63+)")
                }
            }
                
            VStack {
                ForEach(["Four of Kind", "S. Straight", "L. Straight", "Yacht"], id: \.self) { label in
                    ScoreTableGrid(gridContent: label)
                }
                HighlightedScoreTableGrid(gridContent: "Total", highlighted: true)
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
                HighlightedScoreTableGrid(gridContent: viewModel.playerNames[playerID - 1], highlighted: viewModel.currentTurn == playerID)
                
                ForEach(["1","2","3","4"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
            }
            
            VStack {
                ForEach(["5", "6"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
                
                HighlightedScoreTableGrid(gridContent: String(viewModel.playerScores[playerID - 1].score[scoreTypeDictionary["bonus"]!]), highlighted: viewModel.playerScores[playerID - 1].scoreLocked[scoreTypeDictionary["bonus"] ?? 0])
                
                ForEach(["choice", "fullHouse"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
            }
                
            VStack {
                ForEach(["fourOfKind", "smallStraight", "largeStraight", "yacht"], id: \.self) { scoreType in
                    InteractiveScoreTableGrid(viewModel: viewModel, playerID: playerID, scoreType: scoreType)
                }
                
                HighlightedScoreTableGrid(gridContent: String(viewModel.playerScores[playerID - 1].totalScore), highlighted: viewModel.playerScores[2-playerID].totalScore < viewModel.playerScores[playerID - 1].totalScore)
            }
        }
    }
}

struct ScoreTableGrid: View {
    @Environment(\.colorScheme) var colorScheme
    
    var gridContent: String
    var shape = Rectangle()
    
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(colorScheme == .dark ? .black : .white)
            shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue)
            Text(gridContent)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct HighlightedScoreTableGrid: View {
    @Environment(\.colorScheme) var colorScheme
    
    var gridContent: String
    var highlighted: Bool
    var shape = Rectangle()
    
    var body: some View {
        ZStack {
            if !highlighted {
                shape.fill().foregroundColor(colorScheme == .dark ? .black : .white)
                shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue)
                Text(gridContent)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            } else {
                shape.fill().foregroundColor(colorScheme == .dark ? .yellow : .blue)
                shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue)
                Text(gridContent)
                    .foregroundColor(colorScheme == .dark ? .black : .white).font(Font.body.weight(.bold))
            }
        }
    }
}

struct InteractiveScoreTableGrid: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
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
                if self.gridContent == "0" {
                    shape.fill().foregroundColor(colorScheme == .dark ? .black : .white)
                    shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue)
                    Text(gridContent).foregroundColor(.gray)
                } else {
                    shape.fill().foregroundColor(colorScheme == .dark ? .yellow : .blue)
                    shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue)
                    Text(gridContent).foregroundColor(colorScheme == .dark ? .black : .white).font(Font.body.weight(.bold))
                }
            } else {
                shape.fill().foregroundColor(colorScheme == .dark ? .black : .white)
                shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue)
                Text(gridContent).foregroundColor(colorScheme == .dark ? .white : .black).font(Font.body.weight(.bold))
            }
        }
        .onTapGesture {
            if viewModel.currentTurn == playerID && !viewModel.isBot[playerID] && viewModel.remainingRolls < 3 && viewModel.playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!] == false {
                viewModel.addToScore(scoreType, playerID)
                viewModel.passTurn()
            }
        }
    }
}
