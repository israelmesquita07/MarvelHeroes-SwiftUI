//
//  ContentView.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = HeroViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    NavigationLink(destination: DetailsContentView(hero: hero)) {
                        HeroRow(hero: hero)
                            .onAppear {
                                guard let lastHero = viewModel.heroes.last else {
                                    return
                                }
                                if hero == lastHero && !viewModel.isLoading {
                                    viewModel.nextPage()
                                }
                            }
                    }
                    .listRowBackground(Color.black)
                }
                if viewModel.isLoading {
                    ZStack {
                        Color.black
                        
                        ProgressView()
                            .padding()
                            .tint(Color.red)
                            .progressViewStyle(.circular)
                            .scaleEffect(2.0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .listRowBackground(Color.black)
                }
            }
            .background(Color.black)
            .scrollContentBackground(.hidden)
            .navigationTitle("Marvel Heroes")
            .foregroundStyle(.white)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.nextPage()
            }
        }
        .modifier(NavigationBarColor(backgroundColor: .black, tintColor: .white))
        .searchable(text: $searchText, isPresented: .constant(true), prompt: "Find your hero")
        .modifier(TextFieldSearchBarColor(backgroundColor: .white, tintColor: .black))
    }
}

#Preview {
    ContentView()
}
