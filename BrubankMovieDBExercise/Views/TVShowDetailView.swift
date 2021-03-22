//
//  TVShowDetailView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI

struct TVShowDetailView: View {
    // TODO: Cuando agrego el @Enviroment desaparece la imagen que cargue con el ImageLoader
    
    // @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let tvShowId: Int
    @ObservedObject private var tvShowDetailState = TVShowDetailState()
    
    
//    var btnBack : some View { Button(action: {
//    //    self.presentationMode.wrappedValue.dismiss()
//    }) {
//        HStack {
//            Image("BackButton")
//                .aspectRatio(contentMode: .fit)
//                .foregroundColor(.white)
//
//        }
//    }
//    }
    
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.tvShowDetailState.isLoading, error: self.tvShowDetailState.error) {
                self.tvShowDetailState.loadTVShow(id: self.tvShowId)
            }
            
            if tvShowDetailState.tvShow != nil {
                TVShowDetailListView(tvShow: self.tvShowDetailState.tvShow!)
            }
        }
        .navigationBarTitle(tvShowDetailState.tvShow?.name ?? "No title")
        // TODO: no lo agrego porque no anda la imagen
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: btnBack)
        .onAppear {
            self.tvShowDetailState.loadTVShow(id: self.tvShowId)
        }
    }
}

struct TVShowDetailListView: View {
    
    let tvShow: TVShow
    let imageLoader = ImageLoader()
    
    var body: some View {    
        ZStack {
            // TODO: revisar que entra en null porque no cargo todavia la imagen
            if imageLoader.image != nil {
                Color.init(imageLoader.image?.averageColor ?? UIColor.black)
                    .ignoresSafeArea()
            }
            //
            ScrollView{
                TVShowDetailImage(imageLoader: imageLoader, imageURL: self.tvShow.posterURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                
                
                VStack {
                    Text(tvShow.name)
                        .font(.title)
                        .bold()
                    Text(tvShow.firstAirDate?.prefix(4) ?? "No Year")
                }.padding()
                
                Button(action: {
                    
                    
                }, label: {
                    Text("SUSCRIBIRME")
                        .frame(minWidth: 0, maxWidth: 150)
                        .font(.system(size: 16))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                })
                .padding()
                VStack(alignment: .leading){
                    Text("OVERVIEW \n")
                        .bold()
                    Text(tvShow.overview)
                }
                .padding()
                Spacer()
                
            }.padding()
        }
        }
        
}

struct TVShowDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .frame(width: 182, height: 273)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            }
            else {
                Rectangle().fill(Color.gray.opacity(0.3)).frame(width: 182, height: 273)
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
    
}





//MARK: - Preview Details
struct TVShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowDetailView(tvShowId: TVShow.exampleTVShow.id).preferredColorScheme(.dark)
    }
}
