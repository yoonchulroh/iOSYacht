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
        //self.viewModel.setBotPlayer()
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
    
    static var previews: some View {
        ContentView(viewModel: game)
    }
}
