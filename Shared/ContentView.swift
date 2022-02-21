//
//  ContentView.swift
//  Shared
//
//  Created by Eduardo Callado on 21/02/22.
//

import SwiftUI

struct Keyboard: View {
	@ObservedObject var viewModel: ViewModel // State ?
	
	let firstLine = "QWERTYUIOP".map{ String($0) }
	let secondLine = "ASDFGHJKL".map{ String($0) }
	let thirdLine = "⏎ZXCVBNM⌫".map{ String($0) }
	
	func createLine(letters: [String]) -> some View {
		HStack(spacing: 4) {
			ForEach(letters, id: \.self) { letter in
				let minWidth: CGFloat = ["⌫", "⏎"].contains(letter) ? 50 : 20
				
				Button {
					switch letter {
					case "⏎":
						print("enter")
						
						viewModel.addGuess()
					case "⌫":
						print("backspace")
						
						viewModel.removeLetter()
					default:
						print("letter: \(letter)")
						
						viewModel.addLetter(letter: letter)
					}
				} label: {
					Text(letter)
						.textCase(.uppercase)
				}
				.frame(minWidth: minWidth, maxWidth: .infinity, minHeight: 60, alignment: .center)
				.background(Color.init(white: 0.7))
				.cornerRadius(4)
				.foregroundColor(Color.white)
				
			}
		}
	}
	
	var body: some View {
		VStack(spacing: 4) {
			createLine(letters: firstLine)
			createLine(letters: secondLine)
			createLine(letters: thirdLine)
		}
		.frame(maxWidth: .infinity, alignment: .center)
		.aspectRatio(10, contentMode: .fit)
		.padding(12)
	}
}

struct Line: View {
	@State var lettersString: [LetterString]
	
	func Letter(letterString: LetterString) -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 4,
							 style: .continuous)
				.foregroundColor(letterString.color)
				.aspectRatio(1.0, contentMode: .fit)
			
			Text(letterString.letter)
				.foregroundColor(.white)
				.font(.system(size: 30))
				.bold()
		}
	}
	
    var body: some View {
		HStack {
			ForEach(lettersString, id: \.self) { letter in
				Letter(letterString: letter)
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

struct ContentView: View {
	@ObservedObject var viewModel: ViewModel = ViewModel()
	
	var body: some View {
//		NavigationView {
			VStack {
				Words(viewModel: viewModel)
				
				Keyboard(viewModel: viewModel)
			}
//			.navigationTitle("B2Wordle")
//			.navigationBarTitleDisplayMode(.inline)
//			.toolbar {
//				ToolbarItemGroup(placement: .navigationBarLeading) {
//					Button {
//						//
//					} label: {
//						Image(systemName: "info.circle")
//					}
//					.foregroundColor(.primary)
//				}
//
//				ToolbarItemGroup(placement: .navigationBarTrailing) {
//					Button {
//						//
//					} label: {
//						Image(systemName: "square.and.arrow.up")
//					}
//					.foregroundColor(.primary)
//
//					Button {
//						//
//					} label: {
//						Image(systemName: "gearshape")
//					}
//					.foregroundColor(.primary)
//				}
//			}
//		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
    }
}
