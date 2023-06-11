//
//  ContentView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch(viewModel.gameMode) {
        case(.home):
            HomeView(viewModel: viewModel)
        case(.singleplayer):
            GameView(viewModel: viewModel)
        case(.multiplayer):
            GameView(viewModel: viewModel)
        case(.settings):
            SettingsView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var game: ViewModel = ViewModel()
    
    static var previews: some View {
        ContentView(viewModel: game)
    }
}
