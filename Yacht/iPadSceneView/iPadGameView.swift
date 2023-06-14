//
//  iPadGameView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/12.
//

import Foundation
import SwiftUI
import UIKit

struct iPadGameView: View {
    @ObservedObject var viewModel: ViewModel
    
    var deviceHeight = UIScreen.main.bounds.height
    var deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            ScoreView(viewModel: viewModel)
                .frame(width: deviceWidth * 2 / 3)
            VStack {
                HStack {
                    HomeButtonView(viewModel: viewModel).padding(.leading)
                    ProbabilitySimulationView(viewModel: viewModel)
                    RefreshButtonView(viewModel: viewModel).padding(.trailing)
                }
                .frame(height: deviceHeight / 15)
                Spacer()
                MessageView(viewModel: viewModel)
                    .font(Font.title.weight(.bold)).padding(.bottom)
                    .frame(height: deviceHeight / 5)
                DicesFieldView(viewModel: viewModel)
                Spacer()
                RollButton(viewModel: viewModel)
                Spacer()
            }
            .padding(.trailing, 30)
        }
    }
}
