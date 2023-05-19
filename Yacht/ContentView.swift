//
//  ContentView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ScoreView(viewModel: viewModel)
            DicesFieldView(viewModel: viewModel)
            RollButton(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let game = ViewModel()
    static var previews: some View {
        ContentView(viewModel: game)
    }
}
