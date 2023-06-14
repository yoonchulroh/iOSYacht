//
//  ProbabilitySimulationView.swift
//  Yacht
//
//  Created by 노윤철 on 2023/06/14.
//

import Foundation
import SwiftUI

struct ProbabilitySimulationView: View {
    var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text(String(viewModel.simulatedWinCount[0]))
            Text(String(viewModel.simulatedWinCount[1]))
            Text(String(viewModel.simulatedWinCount[2]))
        }
    }
}
