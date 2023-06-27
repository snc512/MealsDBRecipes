//
//  FavoritesViewModel.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/25/23.
//

import Foundation
import SwiftUI
import Combine


class FavoritesViewModel: ObservableObject {
    @Published private var homeViewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()


    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        observeChanges()
    }
    
    private func observeChanges() {
        homeViewModel.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

     func filterData() -> [Recipe] {
         print(homeViewModel.meals.first?.isFavorite)
         return homeViewModel.meals.filter { $0.isFavorite }
     }
    
    func updateFavoriteStatus(for recipe: Recipe, isFavorite: Bool) {
        if let index = homeViewModel.meals.firstIndex(where: { $0.id == recipe.id }) {
            homeViewModel.meals[index].isFavorite = isFavorite
        }
    }

}
