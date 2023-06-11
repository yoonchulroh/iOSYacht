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
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad && UIDeviceOrientation.unknown.isLandscape {
            HStack {
                ScoreView(viewModel: viewModel)
                VStack {
                    MessageView(viewModel: viewModel)
                    DicesFieldView(viewModel: viewModel)
                    RollButton(viewModel: viewModel)
                }
            }
        } else {
            VStack {
                HStack {
                    HomeButtonView(viewModel: viewModel).padding(.leading)
                    Spacer()
                    RefreshButtonView(viewModel: viewModel).padding(.trailing)
                }
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
