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
    
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(colorScheme == .dark ? .black : .white)
            shape.stroke(lineWidth: 10).foregroundColor(colorScheme == .dark ? .yellow : .blue)
            Text("Remaining Rolls: " + String(viewModel.remainingRolls))
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        .aspectRatio(4, contentMode: .fit)
        .padding(.all)
        .onTapGesture {
            if viewModel.remainingRolls > 0 && !viewModel.isBot[viewModel.currentTurn - 1] {
                viewModel.roll()
            }
        }
    }
}
