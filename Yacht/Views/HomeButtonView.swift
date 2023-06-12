//
//  HomeButton.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI
import UIKit

struct HomeButtonView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var deviceHeight = UIScreen.main.bounds.height
    var deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        Image(systemName: "house")
            .resizable()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(width: deviceHeight / 60, height: deviceHeight / 60)
            .onTapGesture {
                viewModel.switchGameMode(destination: .home)
            }
    }
}

struct RefreshButtonView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var deviceHeight = UIScreen.main.bounds.height
    var deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        Image(systemName: "arrow.2.squarepath")
            .resizable()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(width: deviceHeight / 60, height: deviceHeight / 60)
            .onTapGesture {
                viewModel.resetScore()
            }
    }
}
