//
//  YachtApp.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

@main
struct YachtApp: App {
    let game: ViewModel
    let botPlayer: BotPlayer
    
    init() {
        game = ViewModel()
        botPlayer = BotPlayer(playerID: 2)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game, botPlayer: botPlayer)
        }
    }
}
