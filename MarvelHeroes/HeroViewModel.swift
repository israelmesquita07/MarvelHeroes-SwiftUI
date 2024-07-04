//
//  HeroViewModel.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 04/06/24.
//

import Foundation

final class HeroViewModel: ObservableObject {
    @Published var heroes = [Hero]()
    @Published var isLoading = false
    private var totalHeroes = 1
    private var page = 0
    
    func nextPage(name: String) {
        guard !isLoading else { return }
        if heroes.count == totalHeroes {
            return
        }
        getHero(name: name)
    }
    
    func searchHeroes(name: String) {
        resetVariables()
        getHero(name: name)
    }
    
    private func getHero(name: String) {
        isLoading = true
        NetworkAPI().fetchData(name: name, page: page) { [weak self] (result: Result<MarvelInfo, NetworkingError>) in
            print(result)
            guard let self else { return }
            switch result {
            case .success(let success):
                totalHeroes = success.data.total
                heroes += success.data.results
                page += 1
            case .failure(let failure):
                print("failure: \(failure.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    private func resetVariables() {
        totalHeroes = 1
        page = 0
        heroes = []
    }
}
