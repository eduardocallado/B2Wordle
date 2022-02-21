//
//  ViewModel.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 21/02/22.
//

import Foundation
import SwiftUI

struct LetterString: Hashable {
	enum LetterState {
		case rightPlace
		case wrongPlace
		case invalidLetter
//		case maybe
		case emptyLetter
	}
	
	var letter: String = ""
	var state: LetterState = .emptyLetter
	
	var color: Color {
		switch state {
		case .rightPlace:
			return .green
		case .wrongPlace:
			return .yellow
		case .invalidLetter:
			return .gray
//		case .maybe:
//			return .orange
		case .emptyLetter:
			return .black
		}
	}
}

class ViewModel: ObservableObject {
	let answers = ["FONTE", "LINCE"]
//	let allowed = ["FONTE", "LINCE", "PAPEL", "TEMPO", "BANDA"]
	
	var answer: String = "ALADO"
	
	var currentColumn = 0
	var currentRow = 0
	
	@Published var guesses: [[LetterString]] = [[LetterString(), LetterString(), LetterString(), LetterString(), LetterString()],
												[LetterString(), LetterString(), LetterString(), LetterString(), LetterString()],
												[LetterString(), LetterString(), LetterString(), LetterString(), LetterString()],
												[LetterString(), LetterString(), LetterString(), LetterString(), LetterString()],
												[LetterString(), LetterString(), LetterString(), LetterString(), LetterString()],
												[LetterString(), LetterString(), LetterString(), LetterString(), LetterString()]]
}

extension ViewModel {
	func addLetter(letter: String) {
		if currentColumn == 5 { return }
		
		guesses[currentRow][currentColumn] = LetterString(letter: letter, state: .emptyLetter)
		currentColumn+=1
	}
	
	func removeLetter() {
		if currentColumn == 0 { return }
		
		currentColumn -= 1
		guesses[currentRow][currentColumn] = LetterString(letter: "", state: .emptyLetter)
	}
	
	func addGuess() {
		let letterStringArray = guesses[currentRow]
		let currentWord = letterStringArray.reduce("") { $0 + $1.letter }
		
		print("currentWord = \(currentWord)")
		
		if currentWord.count < 5 {
			print("> Palavra incompleta.")
			return
		}
		
//		if !allowed.contains(currentWord) {
//			print("> Palavra inválida.")
//			return
//		}
		
		if //allowed.contains(currentWord) &&
		   answer != currentWord {
			print("> Palavra válida, mas errada.")
			
			validateCurrentWord()
			
			if currentRow == 5 {
				print(">> Suas tentativas acabaram. :(")
				// TODO: End game
				return
			}
			
			currentRow += 1
			currentColumn = 0
			
			return
		}
		
		if answer == currentWord {
			print(">> Palavra certa! \\o/")
			
			validateCurrentWord()
			
			// TODO: End game
		}
	}
	
	func validateCurrentWord() {
		let letterStringArray = guesses[currentRow]
		
		var tempAnswerChars = answer.map { String($0) }
		
		for (index, var letterString) in letterStringArray.enumerated() {
			if String(answer[index]) == letterString.letter {
				letterString.state = .rightPlace
				tempAnswerChars[index] = "+"
			}
			
			guesses[currentRow][index] = letterString
		}
		
		for (index, var letterString) in letterStringArray.enumerated() {
			if String(answer[index]) == letterString.letter {
				continue
			}
			
			if !tempAnswerChars.contains(letterString.letter) {
				letterString.state = .invalidLetter
			} else {
				letterString.state = .wrongPlace
				if let firstIndex = tempAnswerChars.firstIndex(of: letterString.letter) {
					tempAnswerChars[firstIndex] = "-"
					letterString.state = .wrongPlace
				} else {
					letterString.state = .invalidLetter
				}
			}
			
			guesses[currentRow][index] = letterString
		}
	}
}

extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}
