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
    
    let diceFaces = ["0.square", "1.square", "2.square", "3.square", "4.square", "5.square", "6.square"]
    
    let shape = RoundedRectangle(cornerRadius: 5)
    
    var body: some View {
        ZStack {
            if viewModel.dicePart.dices[diceIndex].locked {
                shape.fill().foregroundColor(colorScheme == .dark ? .yellow : .blue).aspectRatio(1, contentMode: .fit)
                shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue).aspectRatio(1, contentMode: .fit)
                Image(systemName: diceFaces[viewModel.dicePart.dices[diceIndex].diceFace])
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
            } else {
                shape.fill().foregroundColor(colorScheme == .dark ? .black : .white).aspectRatio(1, contentMode: .fit)
                shape.stroke(lineWidth: 3).foregroundColor(colorScheme == .dark ? .yellow : .blue).aspectRatio(1, contentMode: .fit)
                Image(systemName: diceFaces[viewModel.dicePart.dices[diceIndex].diceFace])
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
