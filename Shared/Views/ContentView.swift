//
//  ContentView.swift
//  Shared
//
//  Created by Eduardo Callado on 21/02/22.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel: ViewModel = ViewModel()
	
	var body: some View {
//		NavigationView {
		
			VStack {
				MessageView(viewModel: viewModel)
				
				Words(viewModel: viewModel)
				
				Keyboard(viewModel: viewModel)
			}
			.onAppear(perform: initViewModel)
		
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
//		}.onAppear(perform: initViewModel)
	}
	
	func initViewModel() {
		viewModel.initViewModel()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
    }
}
