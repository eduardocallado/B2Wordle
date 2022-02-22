//
//  WordView.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import SwiftUI

struct Letter: View {
	@Binding var letterModel: LetterModel
	
	@State var scale = 1.0
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 4,
							 style: .continuous)
				.foregroundColor(letterModel.color)
				.aspectRatio(1.0, contentMode: .fit)
			
				.scaleEffect(scale)
				.animation(.easeInOut(duration: 0.2), value: scale)
				.animationObserver(for: scale, onComplete:  {
					scale = 1.0
				})
			
			Text(letterModel.letter)
				.foregroundColor(.white)
				.font(.system(size: 50))
				.bold()
				.onChange(of: letterModel.letter) { newValue in
					withAnimation {
						scale = 1.2
					}
				}
		}
	}
}

struct Line: View {
//	@State var lettersString: [LetterModel]
	
	@Binding var lettersModel1: LetterModel
	@Binding var lettersModel2: LetterModel
	@Binding var lettersModel3: LetterModel
	@Binding var lettersModel4: LetterModel
	@Binding var lettersModel5: LetterModel
	
	var body: some View {
		HStack {
//			ForEach(lettersString, id: \.self) { letter in
//				Letter(letterModel: letter)
//			}
			
			Letter(letterModel: $lettersModel1)
			Letter(letterModel: $lettersModel2)
			Letter(letterModel: $lettersModel3)
			Letter(letterModel: $lettersModel4)
			Letter(letterModel: $lettersModel5)
		}
		.padding(.horizontal, 12)
	}
}

struct Words: View {
	@ObservedObject var viewModel: ViewModel
	
	var body: some View {
		VStack {
//			ForEach(viewModel.guesses, id: \.self) { letters in
//				Line(lettersString: letters)
//			}
			
			Line(lettersModel1: $viewModel.guesses[0][0],
				 lettersModel2: $viewModel.guesses[0][1],
				 lettersModel3: $viewModel.guesses[0][2],
				 lettersModel4: $viewModel.guesses[0][3],
				 lettersModel5: $viewModel.guesses[0][4])
			
			Line(lettersModel1: $viewModel.guesses[1][0],
				 lettersModel2: $viewModel.guesses[1][1],
				 lettersModel3: $viewModel.guesses[1][2],
				 lettersModel4: $viewModel.guesses[1][3],
				 lettersModel5: $viewModel.guesses[1][4])
			
			Line(lettersModel1: $viewModel.guesses[2][0],
				 lettersModel2: $viewModel.guesses[2][1],
				 lettersModel3: $viewModel.guesses[2][2],
				 lettersModel4: $viewModel.guesses[2][3],
				 lettersModel5: $viewModel.guesses[2][4])
			
			Line(lettersModel1: $viewModel.guesses[3][0],
				 lettersModel2: $viewModel.guesses[3][1],
				 lettersModel3: $viewModel.guesses[3][2],
				 lettersModel4: $viewModel.guesses[3][3],
				 lettersModel5: $viewModel.guesses[3][4])
			
			Line(lettersModel1: $viewModel.guesses[4][0],
				 lettersModel2: $viewModel.guesses[4][1],
				 lettersModel3: $viewModel.guesses[4][2],
				 lettersModel4: $viewModel.guesses[4][3],
				 lettersModel5: $viewModel.guesses[4][4])
			
			Line(lettersModel1: $viewModel.guesses[5][0],
				 lettersModel2: $viewModel.guesses[5][1],
				 lettersModel3: $viewModel.guesses[5][2],
				 lettersModel4: $viewModel.guesses[5][3],
				 lettersModel5: $viewModel.guesses[5][4])
			
		}
	}
}
