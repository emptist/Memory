//
//  ContentView.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
			HStack {
				ForEach(0..<4, content: { index in
					CardView(isFaceUp: index > 2)
				})
		}
		.font(.largeTitle)
		.padding()
		.foregroundColor(Color.orange)
	}
}

struct CardView: View {
	var isFaceUp = false
	var body: some View {
		ZStack {
			if isFaceUp {
			RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
			RoundedRectangle(cornerRadius: 10.0).stroke()
			
			Text("🐵")
				
			} else {
			RoundedRectangle(cornerRadius: 10.0).fill()
			}
		}
	}
}




struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

