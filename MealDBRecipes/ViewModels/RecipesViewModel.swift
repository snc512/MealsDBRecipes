//
//  RecipesViewModel.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/19/23.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published var mealDetails: RecipeDetails?

    
//    init() {
//        loadMeals()
//    }
//
//    func toggleFavorite(for recipe: Recipe) {
//        if let index = meals.firstIndex(where: { $0.id == recipe.id }) {
//            meals[index].isFavorite.toggle()
//            self.meals = self.meals  // Reload the array to trigger view updates
//        }
//    }

//    private func saveMeals() {
//        // Save the updated `meals` array to a persistent storage mechanism in this case UserDefaults
//        // If I was building a full developed iOS I would opt to use CoreData and create persisted DB objects for all our models
//        do {
//            let encodedData = try JSONEncoder().encode(meals)
//            UserDefaults.standard.set(encodedData, forKey: "meals")
//        } catch {
//            print("Error encoding meals: \(error)")
//        }
//    }

//    private func loadMeals() {
//        // Load the `meals` array from UserDefaults
//        if let encodedData = UserDefaults.standard.data(forKey: "meals") {
//            do {
//                let decodedData = try JSONDecoder().decode([Recipe].self, from: encodedData)
//                meals = decodedData
//            } catch {
//                print("Error decoding meals: \(error)")
//            }
//        }
//    }
}
