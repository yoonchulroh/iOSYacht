//
//  ContinueGameView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/21.
//

import Foundation
import SwiftUI

struct ContinueGameView: View {
    @ObservedObject var viewModel: ViewModel
    let shape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        ZStack {
            if UserDefaults.standard.bool(forKey: "saveGameExists") {
                shape.fill().foregroundColor(.green)
            } else {
                shape.fill().foregroundColor(.gray)
            }
            Text("Continue Playing").font(Font.title2.weight(.bold)).foregroundColor(.white)
        }
        .aspectRatio(4, contentMode: .fit)
        .padding(.all)
        .onTapGesture {
            if UserDefaults.standard.bool(forKey: "saveGameExists") {
                if UserDefaults.standard.integer(forKey: "gameMode") == 2 {
                    viewModel.switchGameMode(destination: .singleplayer, loadPreviousGame: true)
                } else if UserDefaults.standard.integer(forKey: "gameMode") == 3 {
                    viewModel.switchGameMode(destination: .multiplayer, loadPreviousGame: true)
                }
            }
        }
    }
}
