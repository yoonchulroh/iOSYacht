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
    var player1WinRatio: Float
    var player2WinRatio: Float
    var drawRatio: Float
    
    init(viewModel: ViewModel, assignedWidth: CGFloat) {
        self.viewModel = viewModel
        self.assignedWidth = assignedWidth
        
        if viewModel.simulatedWinCount != [0,0,0] {
            self.totalSimulation = viewModel.simulatedWinCount[0] + viewModel.simulatedWinCount[1] + viewModel.simulatedWinCount[2]
            self.player1WinRatio = Float(viewModel.simulatedWinCount[1]) / Float(self.totalSimulation)
            self.player2WinRatio = Float(viewModel.simulatedWinCount[2]) / Float(self.totalSimulation)
            self.drawRatio = Float(viewModel.simulatedWinCount[0]) / Float(self.totalSimulation)
        }
        else {
            self.totalSimulation = 3
            self.player1WinRatio = 1
            self.player2WinRatio = 1
            self.drawRatio = 1
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: CGFloat(player1WinRatio) * assignedWidth)
                Text(String(Int(player1WinRatio * 100)) + "%")
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: CGFloat(drawRatio) * assignedWidth)
                Text(String(Int(drawRatio * 100)) + "%")
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: CGFloat(player2WinRatio) * assignedWidth)
                Text(String(Int(player2WinRatio * 100)) + "%")
            }
        }
    }
}
