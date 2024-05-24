//
//  ContentView.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var heroes: [Hero] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(heroes, id: \.id) { hero in
                    HeroRow(hero: hero)
                        .listRowBackground(Color.black)
                }
            }
            .background(.black)
            .scrollContentBackground(.hidden)
            .navigationTitle("Marvel Heroes")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                NetworkAPI().fetchData(name: "", page: 1) { (result: Result<MarvelInfo, NetworkingError>) in
                    print(result)
                    if case let .success(success) = result {
                        heroes = success.data.results
                    }
                }
            }
        }
        .modifier(NavigationBarColor(backgroundColor: .black, tintColor: .white))

    }
}

#Preview {
    ContentView()
}
