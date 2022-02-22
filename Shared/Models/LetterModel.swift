//
//  LetterModel.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import SwiftUI

struct LetterModel: Hashable {
	enum LetterState {
		case rightPlace
		case wrongPlace
		case invalidLetter
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
		case .emptyLetter:
			return .init(white: 0.2)
		}
	}
}
