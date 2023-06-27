//
//  MealViewModel.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/25/23.
//

import Foundation
import SwiftUI

class MealViewModel: ObservableObject {
    @Published private var homeViewModel: HomeViewModel
    private let mealsDBService = MealsDBService()
    @Published public var meal: Recipe
    @Published public var mealDetails: RecipeDetails? = nil
    
    init(recipe: Recipe, homeViewModel: HomeViewModel) { // Pass the recipe to the initializer
        self.meal = recipe
        self.homeViewModel = homeViewModel
   }
    
    func toggleFavorite() {
        self.meal.isFavorite.toggle()
        saveMeals() // Save the updated meals array
    }

    private func saveMeals() {
        // Save the updated `meals` array to a persistent storage mechanism in this case UserDefaults
        // If I was building a full developed iOS I would opt to use CoreData and create persisted DB objects for all our models
        do {
            let encodedData = try JSONEncoder().encode(homeViewModel.meals)
            UserDefaults.standard.set(encodedData, forKey: "meals")
        } catch {
            print("Error encoding meals: \(error)")
        }
    }

    private func loadMeals() {
        // Load the `meals` array from UserDefaults
        if let encodedData = UserDefaults.standard.data(forKey: "meals") {
            do {
                let decodedData = try JSONDecoder().decode([Recipe].self, from: encodedData)
                homeViewModel.meals = decodedData
            } catch {
                print("Error decoding meals: \(error)")
            }
        }
    }

    func getMealDetails(mealID: String) {
        mealsDBService.getMealDetails(mealID: mealID) { result in
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    self.mealDetails = meal
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
