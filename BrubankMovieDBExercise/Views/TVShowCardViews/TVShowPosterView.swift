//
//  TVShowPosterView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import SwiftUI

struct TVShowPosterView: View {
    let tvShow: TVShow
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                VStack{
                    Text(tvShow.name)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxHeight: 273)
        .onAppear {
            self.imageLoader.loadImage(with: self.tvShow.posterURL)
        }
    }
}

struct TVShowPosterView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowPosterView(tvShow: TVShow.exampleTVShow)
    }
}
