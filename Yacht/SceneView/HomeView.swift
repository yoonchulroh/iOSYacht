//
//  HomeView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI
import UIKit

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    var deviceType: String = UIDevice.current.localizedModel
    var deviceHeight = UIScreen.main.bounds.height
    var deviceWidth = UIScreen.main.bounds.width
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        if deviceType == "iPad" {
            iPadHomeView(viewModel: viewModel)
        } else {
            VStack {
                Spacer()
                HStack {
                    Image("coloredDice")
                        .resizable()
                        .frame(width: 150, height: 150)
                    Text("Yacht!").font(Font.largeTitle.weight(.bold)).padding(.trailing)
                }
                Spacer()
                
                //GameModeSelectView(viewModel: viewModel, buttonColor: .green, buttonContent: "Sandbox", destination: .testLuck)
                
                ContinueGameView(viewModel: viewModel)
                
                GameModeSelectView(viewModel: viewModel, buttonColor: .blue, buttonContent: "Singleplayer", destination: .singleplayer)
                
                GameModeSelectView(viewModel: viewModel, buttonColor: .red, buttonContent: "Multiplayer", destination: .multiplayer)
            }
        }
    }
}
