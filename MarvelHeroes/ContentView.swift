//
//  ContentView.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = HeroViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    HeroRow(hero: hero)
                        .listRowBackground(Color.black)
                        .onAppear {
                            guard let lastHero = viewModel.heroes.last else {
                                return
                            }
                            if hero.id == lastHero.id && !viewModel.isLoading {
                                viewModel.nextPage()
                            }
                        }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .background(.black)
            .scrollContentBackground(.hidden)
            .navigationTitle("Marvel Heroes")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.nextPage()
            }
        }
        .modifier(NavigationBarColor(backgroundColor: .black, tintColor: .white))

    }
}

#Preview {
    ContentView()
}
