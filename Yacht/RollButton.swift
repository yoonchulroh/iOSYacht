//
//  RollButton.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

struct RollButton: View {
    @ObservedObject var viewModel: ViewModel
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 10).foregroundColor(.blue)
            Text("Remaining Rolls: " + String(viewModel.remainingRolls))
        }
        .aspectRatio(4, contentMode: .fit)
        .padding(.all)
        .onTapGesture {
            if viewModel.remainingRolls > 0 {
                viewModel.roll()
            }
        }
    }
}
