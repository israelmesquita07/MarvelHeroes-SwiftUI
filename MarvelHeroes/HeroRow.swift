//
//  HeroRow.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 23/05/24.
//

import SwiftUI

struct HeroRow: View {
    let hero: Hero
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: hero.thumbnail.url))
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.red, lineWidth: 2.0))
            VStack(alignment: .leading) {
                Text(hero.name)
                    .foregroundStyle(.white)
                    .font(.headline)
            }
        }
        .background(.black)
    }
}

#Preview {
    HeroRow(hero: Hero(id: 0, name: "Hero Name", description: "Hero description", thumbnail: Thumbnail(path: "", ext: "")))
}
