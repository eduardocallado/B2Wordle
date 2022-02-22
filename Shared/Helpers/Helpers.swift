//
//  Helpers.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import Foundation

extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}
