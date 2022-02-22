//
//  WordView.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import SwiftUI

struct Letter: View {
	@State var letterModel: LetterModel
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 4,
							 style: .continuous)
				.foregroundColor(letterModel.color)
				.aspectRatio(1.0, contentMode: .fit)
			
			Text(letterModel.letter)
				.foregroundColor(.white)
				.font(.system(size: 50))
				.bold()
		}
	}
}

struct Line: View {
	@State var lettersString: [LetterModel]
	
	var body: some View {
		HStack {
			ForEach(lettersString, id: \.self) { letter in
				Letter(letterModel: letter)
			}
		}
		.padding(.horizontal, 12)
	}
}

struct Words: View {
	@ObservedObject var viewModel: ViewModel
	
	var body: some View {
		VStack {
			ForEach(viewModel.guesses, id: \.self) { letters in
				Line(lettersString: letters)
			}
		}
	}
}
