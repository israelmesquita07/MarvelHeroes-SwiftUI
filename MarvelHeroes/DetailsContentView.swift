//
//  DetailsContentView.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 07/06/24.
//

import SwiftUI

struct DetailsContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    private let hero: Hero
    private let description: String
    
    init(hero: Hero) {
        self.hero = hero
        self.description = hero.description.isEmpty ? "No description" : hero.description
    }
    
    var body: some View {
        VStack(spacing: 12.0) {
            AsyncImage(url: URL(string: hero.thumbnail.url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .border(Color.black, width: 5.0)
            } placeholder: {
                ProgressView()
                    .padding()
                    .tint(Color.red)
                    .progressViewStyle(.circular)
                    .scaleEffect(2.0)
                    .background(Color.black)
            }
            
            Text(description)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .navigationTitle(hero.name)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .tint(Color.white)
            }
        }
        .background(Color.black)
    }
}

#Preview {
    DetailsContentView(hero: Hero(id: 0, name: "Hero Name", description: "Hero description. It's a hero as you can see. Or maybe not.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", ext: "jpg")))
}
