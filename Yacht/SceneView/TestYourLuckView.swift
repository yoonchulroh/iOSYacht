//
//  TestYourLuckView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI

struct TestYourLuckView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                HomeButtonView(viewModel: viewModel).padding(.leading)
                Spacer()
                RefreshButtonView(viewModel: viewModel).padding(.trailing)
            }
            Spacer()
            Text("Test Your Luck").font(Font.title2.weight(.bold)).padding(.all)
            DicesFieldView(viewModel: viewModel)
            RollButton(viewModel: viewModel, isHome: true)
            Spacer()
        }
    }
}
