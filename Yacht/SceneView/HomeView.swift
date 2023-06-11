//
//  HomeView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image("coloredDice")
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("Yacht!").font(Font.title.weight(.bold)).padding(.trailing)
            }
            Spacer()
            
            ZStack {
                shape.fill().foregroundColor(.green)
                Text("Test Your Luck").font(Font.title2.weight(.bold)).foregroundColor(.white)
            }
            .aspectRatio(4, contentMode: .fit)
            .padding(.all)
            .onTapGesture {
                viewModel.switchGameMode(destination: .testLuck)
            }
            
            ZStack {
                shape.fill().foregroundColor(.blue)
                Text("Singleplayer").font(Font.title2.weight(.bold)).foregroundColor(.white)
            }
            .aspectRatio(4, contentMode: .fit)
            .padding(.all)
            .onTapGesture {
                viewModel.switchGameMode(destination: .singleplayer)
            }
            
            ZStack {
                shape.fill().foregroundColor(.red)
                Text("Multiplayer").font(Font.title2.weight(.bold)).foregroundColor(.white)
            }
            .aspectRatio(4, contentMode: .fit)
            .padding(.all)
            .onTapGesture {
                viewModel.switchGameMode(destination: .multiplayer)
            }
            
            /*
            ZStack {
                shape.fill().foregroundColor(.yellow)
                Text("Settings").font(Font.title2.weight(.bold)).foregroundColor(.white)
            }
            .aspectRatio(4, contentMode: .fit)
            .padding(.all)
            .onTapGesture {
                viewModel.switchGameMode(destination: .settings)
            }
            */
        }
    }
}
