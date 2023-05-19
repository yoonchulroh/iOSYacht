//
//  YachtApp.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/14.
//

import SwiftUI

@main
struct YachtApp: App {
    let game = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
