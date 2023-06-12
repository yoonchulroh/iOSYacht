//
//  GameModeSelectView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/12.
//

import Foundation
import SwiftUI

struct GameModeSelectView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var buttonColor: Color
    var buttonContent: String
    var destination: GameMode
    
    var body: some View {
        ZStack {
            shape.fill().foregroundColor(buttonColor)
            Text(buttonContent).font(Font.title2.weight(.bold)).foregroundColor(.white)
        }
        .aspectRatio(4, contentMode: .fit)
        .padding(.all)
        .onTapGesture {
            viewModel.switchGameMode(destination: destination)
        }
    }
}
