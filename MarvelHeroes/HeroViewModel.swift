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
        Task {
            await getHero(name: name)
        }
    }
    
    func searchHeroes(name: String) {
        resetVariables()
        Task {
            await getHero(name: name)
        }
    }
    
    private func getHero(name: String) async {
        await MainActor.run { [weak self] in
            self?.isLoading = true
        }

        do {
            let success: MarvelInfo = try await NetworkAPI().fetchData(name: name, page: page)
            await MainActor.run { [weak self] in
                self?.totalHeroes = success.data.total
                self?.heroes += success.data.results
                self?.page += 1
            }
        } catch {
            print("failure: \(error.localizedDescription)")
        }

        await MainActor.run { [weak self] in
            self?.isLoading = false
        }
    }
    
    private func resetVariables() {
        totalHeroes = 1
        page = 0
        heroes = []
    }
}
