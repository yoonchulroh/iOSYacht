//
//  HomeButton.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI

struct HomeButtonView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image(systemName: "house")
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .onTapGesture {
                viewModel.switchGameMode(destination: .home)
            }
    }
}

struct RefreshButtonView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image(systemName: "arrow.counterclockwise")
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .onTapGesture {
                viewModel.resetScore()
            }
    }
}
