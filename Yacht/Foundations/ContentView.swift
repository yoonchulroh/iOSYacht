//
//  ContentView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var botPlayer: BotPlayer
    
    init(viewModel: ViewModel, botPlayer: BotPlayer) {
        self.viewModel = viewModel
        self.botPlayer = botPlayer
        
        self.viewModel.setBotPlayer(botPlayer: botPlayer)
        self.botPlayer.setViewModel(viewModel: viewModel)
    }
    
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

struct ContentView_Previews: PreviewProvider {
    static var game: ViewModel = ViewModel()
    static var botPlayer: BotPlayer = BotPlayer(playerID: 2)
    
    static var previews: some View {
        ContentView(viewModel: game, botPlayer: botPlayer)
    }
}
