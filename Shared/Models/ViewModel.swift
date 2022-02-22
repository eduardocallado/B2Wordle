//
//  ViewModel.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 21/02/22.
//

import SwiftUI

enum GameStatus {
	case initial
	case playing
	case lose
	case win
}

struct MessageModel {
	var messageStatus: MessageStatus = .blank
	
}

enum MessageStatus: String {
	case blank = ""
	case incompleteWord = "Palavra incompleta."
	case invalidWord = "Palavra inválida."
	case wrongWord = "Palavra válida, mas errada."
	case rightWord = "Palavra certa! \\o/"
	case exceededTries = "Suas tentativas acabaram. :("
	
	var color: Color {
		switch self {
		case .blank:
			return .black.opacity(0)
		case .incompleteWord:
			return .orange
		case .invalidWord:
			return .red
		case .wrongWord:
			return .yellow
		case .rightWord:
			return .green
		case .exceededTries:
			return .pink
		}
	}
}

class ViewModel: ObservableObject {
	let answers = ["FONTE", "LINCE", "ALADO"]
	var validWords = ["PAPEL", "TEMPO", "BANDA"]
	var answer = ""
	
	var currentColumn = 0
	var currentRow = 0
	
//	var gameStatus: GameStatus = .initial
	
	@Published var message = MessageModel()
	
	@Published var guesses = [[LetterModel(), LetterModel(), LetterModel(), LetterModel(), LetterModel()],
							  [LetterModel(), LetterModel(), LetterModel(), LetterModel(), LetterModel()],
							  [LetterModel(), LetterModel(), LetterModel(), LetterModel(), LetterModel()],
							  [LetterModel(), LetterModel(), LetterModel(), LetterModel(), LetterModel()],
							  [LetterModel(), LetterModel(), LetterModel(), LetterModel(), LetterModel()],
							  [LetterModel(), LetterModel(), LetterModel(), LetterModel(), LetterModel()]]
	
	@Published var rightLetters: Set<String> = []
	@Published var containsLetters: Set<String> = []
	@Published var wrongLetters: Set<String> = []
	
	func initViewModel() {
		validWords.append(contentsOf: answers)
		answer = "AMAPA" //answers.randomElement() ?? answers[0]
	}
}

extension ViewModel {
	func addLetter(letter: String) {
		if currentColumn == 5 { return }
		
		guesses[currentRow][currentColumn].letter = letter
		
//		guesses[currentRow][currentColumn].animateScale = true
		
//		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
//			self?.guesses[self?.currentRow ?? 0][self?.currentColumn ?? 0].scale = 1.0
//			self?.currentColumn += 1
//		}
		
		currentColumn += 1
	}
	
	func removeLetter() {
		if currentColumn == 0 { return }
		
		currentColumn -= 1
		guesses[currentRow][currentColumn] = LetterModel(letter: "", state: .emptyLetter)
	}
	
	func addGuess() {
		let letterModelArray = guesses[currentRow]
		let currentWord = letterModelArray.reduce("") { $0 + $1.letter }
		
		print("[*] currentWord = \(currentWord)")
		
		if currentWord.count < 5 {
			message.messageStatus = MessageStatus.incompleteWord
			print("[*] > \(message)")
			return
		}
		
//		if !validWords.contains(currentWord) {
//			message.messageStatus = MessageStatus.invalidWord
//			print("[*] > \(message)")
//			return
//		}
		
		colorizeWord()
		
		if //validWords.contains(currentWord) &&
		   answer != currentWord {
			message.messageStatus = MessageStatus.wrongWord
			print("[*] > \(message)")
			
			if currentRow == 5 {
				message.messageStatus = MessageStatus.wrongWord
				print("[*] > \(message)")
//				gameStatus = .lose
				// TODO: End game
				return
			}
			
			currentRow += 1
			currentColumn = 0
			
			return
		}
		
		if answer == currentWord {
			message.messageStatus = MessageStatus.rightWord
			print("[*] > \(message)")
//			gameStatus = .win
			// TODO: End game
		}
	}
	
	private func colorizeWord() {
		let letterModelArray = guesses[currentRow]
		var tempAnswerChars = answer.map { String($0) }
		
		for (index, var letterModel) in letterModelArray.enumerated() {
			if String(answer[index]) == letterModel.letter {
				letterModel.state = .rightPlace
				tempAnswerChars[index] = "+"
				rightLetters.insert(letterModel.letter)
				print("[*] >> set right")
			}
			
			guesses[currentRow][index] = letterModel
		}
		
		for (index, var letterModel) in letterModelArray.enumerated() {
			if String(answer[index]) == letterModel.letter {
				print("[*] >> continue")
				continue
			}
			
			if let firstIndex = tempAnswerChars.firstIndex(of: letterModel.letter) {
				tempAnswerChars[firstIndex] = "-"
				letterModel.state = .wrongPlace
				containsLetters.insert(letterModel.letter)
				print("[*] >> set wrong")
			} else {
				letterModel.state = .invalidLetter
				wrongLetters.insert(letterModel.letter)
				print("[*] >> set invalid")
			}
			
			guesses[currentRow][index] = letterModel
		}
	}
}
