//
//  DiceView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct DiceView: View {
    @ObservedObject var viewModel: ViewModel
    
    var diceIndex: Int
    
    let diceFaces = ["0.square", "1.square", "2.square", "3.square", "4.square", "5.square", "6.square"]
    
    let shape = RoundedRectangle(cornerRadius: 5)
    
    var body: some View {
        ZStack {
            if viewModel.dicePart.dices[diceIndex].locked {
                shape.fill().foregroundColor(.blue).aspectRatio(1, contentMode: .fit)
                shape.stroke(lineWidth: 3).foregroundColor(.blue).aspectRatio(1, contentMode: .fit)
                Image(systemName: diceFaces[viewModel.dicePart.dices[diceIndex].diceFace])
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
            } else {
                shape.fill().foregroundColor(.white).aspectRatio(1, contentMode: .fit)
                shape.stroke(lineWidth: 3).foregroundColor(.blue).aspectRatio(1, contentMode: .fit)
                Image(systemName: diceFaces[viewModel.dicePart.dices[diceIndex].diceFace])
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
        .onTapGesture {
            viewModel.lockToggle(diceIndex)
        }
    }
}
