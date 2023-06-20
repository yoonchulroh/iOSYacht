//
//  GameView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: ViewModel
    var deviceType: String = UIDevice.current.localizedModel
    
    var body: some View {
        if deviceType == "iPad" {
            iPadGameView(viewModel: viewModel)
        } else {
            VStack {
                HStack {
                    HomeButtonView(viewModel: viewModel).padding([.leading, .trailing])
                    ProbabilitySimulationView(viewModel: viewModel, assignedWidth: UIScreen.main.bounds.width * 2 / 3)
                        .frame(width: UIScreen.main.bounds.width * 2 / 3)
                    RefreshButtonView(viewModel: viewModel).padding([.leading, .trailing])
                }
                .padding(.top)
                ScoreView(viewModel: viewModel)
                MessageView(viewModel: viewModel)
                DicesFieldView(viewModel: viewModel)
                HStack {
                    RollButton(viewModel: viewModel)
                    //ResetButton(viewModel: viewModel)
                }
            }
        }
    }
}
