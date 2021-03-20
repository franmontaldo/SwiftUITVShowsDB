//
//  TVShowBackDropView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import SwiftUI

struct TVShowBackDropView: View {
    
    let tvShow: TVShow
    let genre: Genre?
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            ZStack {
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .scaledToFill()
                }
                HStack(){
                    // Title
                    VStack (){
                        Spacer()
                        Text(tvShow.name).foregroundColor(.white).shadow(radius: 5)
                    }
                    Spacer()
                    // Genre
                    VStack (){
                        ZStack{
                            Rectangle()
                                .fill(Color.red.opacity(0.6))
                                .frame(minWidth: 75, idealWidth: 75, maxWidth: 200, minHeight: 24, idealHeight: 24, maxHeight: 24, alignment: .center)
                                .cornerRadius(3.0)
                            Text(genre?.name ?? "n/a").foregroundColor(.white).shadow(radius: 5)
                        }
                        Spacer()
                    }
                }.padding()
                
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(3)
            .shadow(radius: 5)
            
            
            
        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.tvShow.backdropURL)
        }
    }
}

struct TVShowBackDropView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowBackDropView(tvShow: TVShow.exampleTVShow, genre: Genre.exampleGenre)
    }
}
