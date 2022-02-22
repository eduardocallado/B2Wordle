//
//  Keyboard.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import SwiftUI

struct Keyboard: View {
	@ObservedObject var viewModel: ViewModel
	
	var initialScale = 1.0
	var finalScale = 1.3
	
	@State var scale: [String: Double] = [:]
	
	let firstLine = "QWERTYUIOP".map{ String($0) }
	let secondLine = "ASDFGHJKL".map{ String($0) }
	let thirdLine = "⏎ZXCVBNM⌫".map{ String($0) }
	
	func createLine(letters: [String]) -> some View {
		HStack(spacing: 4) {
			ForEach(letters, id: \.self) { letter in
				let minWidth: CGFloat = ["⌫", "⏎"].contains(letter) ? 50 : 20
				
				let backgroundColor: Color = {
					if viewModel.rightLetters.contains(letter) { return Color.green }
					if viewModel.containsLetters.contains(letter) { return Color.yellow }
					if viewModel.wrongLetters.contains(letter) { return Color.red }
					if ["⏎", "⌫"].contains(letter) { return Color.init(white: 0.4) }
					return Color.init(white: 0.6)
				}()
				
				Button {
					switch letter {
					case "⏎":
						print("Key pressed: Enter")
						
						viewModel.addGuess()
					case "⌫":
						print("Key pressed: Backspace")
						
						viewModel.removeLetter()
					default:
						print("Key pressed: Letter: \(letter)")
						
						viewModel.addLetter(letter: letter)
					}
					
					withAnimation {
						scale[letter] = finalScale
					}
				} label: {
					Text(letter)
						.textCase(.uppercase)
					
						.frame(minWidth: minWidth, maxWidth: .infinity, minHeight: 48, alignment: .center)
						.background(backgroundColor)
						.cornerRadius(4)
						.foregroundColor(Color.white)
						.font(.system(size: ["⏎", "⌫"].contains(letter) ? 22 : 18,
									  weight: ["⏎", "⌫"].contains(letter) ? .semibold : .medium))
						.scaleEffect(scale[letter] ?? 1)
						.animation(.easeInOut(duration: 0.1), value: scale[letter])
						.animationObserver(for: scale[letter] ?? initialScale, onComplete:  {
							scale[letter] = initialScale
						})
				}
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
