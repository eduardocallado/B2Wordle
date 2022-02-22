//
//  Helpers.swift
//  B2Wordle
//
//  Created by Eduardo Callado on 22/02/22.
//

import Foundation
import SwiftUI

extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}

public struct AnimationObserverModifier<Value: VectorArithmetic>: AnimatableModifier {
	private let observedValue: Value
	private let onChange: ((Value) -> Void)?
	private let onComplete: (() -> Void)?
	
	public var animatableData: Value {
		didSet {
			notifyProgress()
		}
	}
	
	public init(for observedValue: Value,
				onChange: ((Value) -> Void)?,
				onComplete: (() -> Void)?) {
		self.observedValue = observedValue
		self.onChange = onChange
		self.onComplete = onComplete
		animatableData = observedValue
	}
	
	public func body(content: Content) -> some View {
		content
	}
	
	private func notifyProgress() {
		DispatchQueue.main.async {
			onChange?(animatableData)
			if animatableData == observedValue {
				onComplete?()
			}
		}
	}
}

public extension View {
	func animationObserver<Value: VectorArithmetic>(for value: Value,
													onChange: ((Value) -> Void)? = nil,
													onComplete: (() -> Void)? = nil) -> some View {
		self.modifier(AnimationObserverModifier(for: value,
												   onChange: onChange,
												   onComplete: onComplete))
	}
}
