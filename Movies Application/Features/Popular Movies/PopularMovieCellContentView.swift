//
//  Copyright © Pravin G. All rights reserved.
//

import SwiftUI

extension PopularMovieCell {
	struct ContentView: View {
		let summary: MovieSummary
		
		var body: some View {
			GeometryReader { proxy in
				
				ZStack(alignment: .top) {
					ZStack(alignment: .bottom) {
						AsyncImage(url: summary.thumbnailURL) { image in
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
								.tag("\(summary.id)")
						} placeholder: {
							Image(systemName: "poster")
								.imageScale(.large)
								.foregroundColor(.gray)
						}.border(summary.isPopular ? .red : .clear, width: 5)
						VStack(alignment: .leading) {
							Text("\(summary.title)")
								.font(.headline)
								.lineLimit(1)
								.foregroundColor(.yellow)
								.padding(5)
							Text("\(summary.overview)")
								.font(.subheadline)
								.lineLimit(3)
								.foregroundColor(.white)
								.padding(5)
						}.background(.black.opacity(0.5))
					}
					if summary.isPopular {
						HStack(alignment: .top) {
							Spacer()
							Image("star")
								.resizable()
								.frame(width: 32.0, height: 32.0, alignment: .trailing)
								.padding(10)
						}
					}
				}
				.ignoresSafeArea()
				.frame(width: proxy.size.width, height: proxy.size.height)
			}
		}
	}
}

struct PopularMovieCellContentView_Previews: PreviewProvider {
	static var previews: some View {
		PopularMovieCell.ContentView(summary: .example)
			.previewLayout(.fixed(width: 200, height: 350))
	}
}
