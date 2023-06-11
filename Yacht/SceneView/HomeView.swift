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
    
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        VStack {
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
