//
//  HomeViewModel.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/25/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published public var meals: [Recipe] = []
    private let mealsDBService = MealsDBService()

    func loadData() {
        mealsDBService.getMeals { result in
            switch result {
            case .success(let sortedMeals):
                DispatchQueue.main.async {
                    self.meals = sortedMeals
                }
            case .failure(let error):
                print("Error fetching meals: \(error)")
            }
        }
    }
    
}
