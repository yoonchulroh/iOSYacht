//
//  MessageView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/05/19.
//
import SwiftUI
import UIKit

struct MessageView: View {
    @ObservedObject var viewModel: ViewModel
    var deviceType: String = UIDevice.current.localizedModel
    
    var body: some View {
        Text(viewModel.userMessage)
            .padding(.bottom)
            .font(deviceType == "iPad" ? Font.largeTitle.weight(.bold) : Font.title3.weight(.bold))
            .multilineTextAlignment(.center)
    }
}
