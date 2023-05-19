//
//  BotPlayer.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/19.
//

import Foundation

class BotPlayer: ObservableObject {
    var viewModel: ViewModel?
    var playerID: Int
    
    init(playerID: Int) {
        self.playerID = playerID
    }
    
    func setViewModel(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func playTurn() {
        viewModel!.roll()
        sleep(1)
        viewModel!.roll()
        sleep(1)
        viewModel!.roll()
        var scoreType = reversedScoreTypeDictionary[Int.random(in: 1...12)]!
        while viewModel!.playerScores[playerID - 1].scoreLocked[scoreTypeDictionary[scoreType]!] {
            scoreType = reversedScoreTypeDictionary[Int.random(in: 1...12)]!
        }
        viewModel!.addToScore(scoreType, playerID)
    }
}
