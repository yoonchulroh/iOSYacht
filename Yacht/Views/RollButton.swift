//
//  RollButton.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct RollButton: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let shape = RoundedRectangle(cornerRadius: 20)
    var isHome: Bool = false
    
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(colorScheme == .dark ? .black : .white)
            shape.stroke(lineWidth: 10).foregroundColor(colorScheme == .dark ? .yellow : .blue)
            if viewModel.gameOver {
                Text("Reset")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .font(Font.title3.weight(.bold))
            } else {
                if isHome && viewModel.remainingRolls == 0 {
                    Text("Reset")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(Font.title3.weight(.bold))
                } else {
                    Text("Remaining Rolls: " + String(viewModel.remainingRolls))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(Font.title3.weight(.bold))
                }
            }
        }
        .aspectRatio(4, contentMode: .fit)
        .padding(.all)
        .onTapGesture {
            if viewModel.gameOver {
                viewModel.resetScore()
                viewModel.saveCurrentGame()
            } else {
                if viewModel.remainingRolls > 0 && !viewModel.isBot[viewModel.currentTurn] {
                    viewModel.roll()
                    viewModel.saveCurrentGame()
                } else if isHome && viewModel.remainingRolls == 0 {
                    viewModel.resetScore()
                    viewModel.saveCurrentGame()
                }
            }
        }
    }
}

struct ResetButton: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(.red)
            Text("Reset")
                .foregroundColor(.white)
                .font(Font.body.weight(.bold))
        }
        .aspectRatio(2, contentMode: .fit)
        .onTapGesture {
            viewModel.resetScore()
        }
    }
}
