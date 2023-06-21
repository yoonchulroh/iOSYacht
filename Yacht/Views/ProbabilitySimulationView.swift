//
//  ProbabilitySimulationView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/14.
//

import Foundation
import SwiftUI

struct ProbabilitySimulationView: View {
    @ObservedObject var viewModel: ViewModel
    
    var assignedWidth: CGFloat
    
    var totalSimulation: Int
    var winRatio: [Float] = []
    
    init(viewModel: ViewModel, assignedWidth: CGFloat) {
        self.viewModel = viewModel
        self.assignedWidth = assignedWidth
        
        if viewModel.simulatedWinCount != [0,0,0] {
            self.totalSimulation = viewModel.simulatedWinCount[0] + viewModel.simulatedWinCount[1] + viewModel.simulatedWinCount[2]
            for i in 0 ... viewModel.playerCount {
                self.winRatio.append(Float(viewModel.simulatedWinCount[i]) / Float(self.totalSimulation))
            }
        } else if viewModel.gameOver {
            self.totalSimulation = 3
            for _ in 0 ... viewModel.playerCount {
                self.winRatio.append(0)
            }
            self.winRatio[viewModel.decideWinner()] = 1
            
        } else {
            self.totalSimulation = 3
            for _ in 0 ... viewModel.playerCount {
                self.winRatio.append(1/3)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: CGFloat(winRatio[1]) * assignedWidth)
                Text(String(Int(winRatio[1] * 100)) + "%")
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: CGFloat(winRatio[0]) * assignedWidth)
                Text(String(Int(winRatio[0] * 100)) + "%")
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: CGFloat(winRatio[2]) * assignedWidth)
                Text(String(Int(winRatio[2] * 100)) + "%")
            }
        }
    }
}
