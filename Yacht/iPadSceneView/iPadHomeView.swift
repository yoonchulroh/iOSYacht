//
//  iPadHomeView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/12.
//

import Foundation
import SwiftUI
import UIKit

struct iPadHomeView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    var deviceHeight = UIScreen.main.bounds.height
    var deviceWidth = UIScreen.main.bounds.width
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        HStack {
            Spacer()
            
            HStack {
                Image("coloredDice")
                    .resizable()
                    .frame(width: deviceWidth / 5, height: deviceWidth / 5)
                Text("Yacht!").font(Font.largeTitle.weight(.bold)).padding(.trailing)
            }
            .frame(width: deviceWidth / 3)
            
            Spacer()
            
            VStack {
                //GameModeSelectView(viewModel: viewModel, buttonColor: .green, buttonContent: "Sandbox", destination: .testLuck)
                
                ContinueGameView(viewModel: viewModel)
                
                GameModeSelectView(viewModel: viewModel, buttonColor: .blue, buttonContent: "Singleplayer", destination: .singleplayer)
                
                GameModeSelectView(viewModel: viewModel, buttonColor: .red, buttonContent: "Multiplayer", destination: .multiplayer)
            }
            .frame(width: deviceWidth / 3)
            
            Spacer()
        }
    }
}
