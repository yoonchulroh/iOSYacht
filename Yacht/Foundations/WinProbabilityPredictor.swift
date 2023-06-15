//
//  WinProbabilityPredictor.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/14.
//

import Foundation

class WinProbabilityPredictor {
    
    private let originalViewModel: ViewModel
    
    private var simulationViewModelOriginal: ViewModel
    private var simulationViewModelInstance: ViewModel
    
    var active: Bool
    
    init(viewModel: ViewModel) {
        self.active = true
        
        self.originalViewModel = viewModel
        
        self.simulationViewModelOriginal = viewModel.copy() as! ViewModel
        self.simulationViewModelOriginal.setBotPlayerAllForSimulation()
        
        self.simulationViewModelInstance = self.simulationViewModelOriginal.copy() as! ViewModel
    }
    
    func monteCarloGame() {
        self.simulationViewModelInstance = self.simulationViewModelOriginal.copy() as! ViewModel
        
        while(!self.simulationViewModelInstance.gameOver) {
            if self.simulationViewModelInstance.currentTurn == 1 {
                self.simulationViewModelInstance.botPlayer!.playTurn()
                self.simulationViewModelInstance.passTurn()
            } else {
                self.simulationViewModelInstance.secondBotPlayer!.playTurn()
                self.simulationViewModelInstance.passTurn()
            }
        }
        
        if self.simulationViewModelInstance.playerScores[0].totalScore > self.simulationViewModelInstance.playerScores[1].totalScore {
            self.originalViewModel.updateSimulatedWinCount(playerID: 1)
        } else if self.simulationViewModelInstance.playerScores[0].totalScore < self.simulationViewModelInstance.playerScores[1].totalScore {
            self.originalViewModel.updateSimulatedWinCount(playerID: 2)
        } else {
            self.originalViewModel.updateSimulatedWinCount(playerID: 0)
        }
    }
    
    func runInTheBackground() {
        let interval: UInt32 = 100000
        DispatchQueue.global(qos: .background).async {
            while self.active {
                DispatchQueue.main.async {
                    if self.originalViewModel.newEvent {
                        self.originalViewModel.updateSimulatedWinCount(playerID: -1)
                        self.originalViewModel.newEvent = false
                    }
                    self.monteCarloGame()
                }
                usleep(interval)
            }
        }
    }
}
