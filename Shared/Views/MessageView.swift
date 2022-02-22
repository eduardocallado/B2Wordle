//
//  MessageView.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import SwiftUI

struct MessageView: View {
	@ObservedObject var viewModel: ViewModel = ViewModel()
	
	var body: some View {
		Text(viewModel.message.messageStatus.rawValue)
			.frame(width: 320, height: 36, alignment: .center)
			.font(.system(size: 20, weight: .semibold))
			.foregroundColor(viewModel.message.messageStatus.color)
			.background(viewModel.message.messageStatus.color.opacity(0.1))
			.cornerRadius(8)
	}
}
