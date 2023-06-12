//
//  TestYourLuckView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/11.
//

import Foundation
import SwiftUI
import UIKit

struct TestYourLuckView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var deviceType: String = UIDevice.current.localizedModel
    var deviceHeight = UIScreen.main.bounds.height
    var deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        if deviceType == "iPad" {
            VStack {
                HStack {
                    HomeButtonView(viewModel: viewModel).padding(.leading)
                    Spacer()
                    RefreshButtonView(viewModel: viewModel).padding(.trailing)
                }
                Spacer()
                Text("Test Your Luck").font(Font.title.weight(.bold)).padding(.all)
                Spacer()
                DicesFieldView(viewModel: viewModel)
                RollButton(viewModel: viewModel, isHome: true)
                Spacer()
            }
            .frame(width: deviceWidth / 3)
        } else {
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
}
