//
//  DicesFieldView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct DicesFieldView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            DiceView(viewModel: viewModel, diceIndex: 0)
            DiceView(viewModel: viewModel, diceIndex: 1)
            DiceView(viewModel: viewModel, diceIndex: 2)
            DiceView(viewModel: viewModel, diceIndex: 3)
            DiceView(viewModel: viewModel, diceIndex: 4)
        }
    }
}
