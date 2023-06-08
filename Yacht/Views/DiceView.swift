//
//  DiceView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct DiceView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var diceIndex: Int
    
    let diceFaces = ["diceDefault", "dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    let shape = RoundedRectangle(cornerRadius: 5)
    
    var body: some View {
        ZStack {
            if viewModel.dicePart.dices[diceIndex].locked {
                shape.fill().foregroundColor(colorScheme == .dark ? .yellow : .blue).aspectRatio(1, contentMode: .fit)
                shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue).aspectRatio(1, contentMode: .fit)
                Image(colorScheme == .dark ? diceFaces[viewModel.dicePart.dices[diceIndex].diceFace] : diceFaces[viewModel.dicePart.dices[diceIndex].diceFace] + "White")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
            } else {
                shape.fill().foregroundColor(colorScheme == .dark ? .black : .white).aspectRatio(1, contentMode: .fit)
                //shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue).aspectRatio(1, contentMode: .fit)
                Image(colorScheme == .light ? diceFaces[viewModel.dicePart.dices[diceIndex].diceFace] : diceFaces[viewModel.dicePart.dices[diceIndex].diceFace] + "White")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(colorScheme == .dark ? .yellow : .blue)
            }
        }
        .padding(.horizontal)
        .onTapGesture {
            viewModel.lockToggle(diceIndex)
        }
    }
}
