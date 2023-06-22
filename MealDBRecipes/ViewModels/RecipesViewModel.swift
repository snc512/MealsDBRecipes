//
//  RecipesViewModel.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/19/23.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published public var meals: [Recipe] = []
    @Published var mealDetails: RecipeDetails?
    
    struct MealsResponse: Decodable {
        let meals: [Recipe]
    }
    
    struct MealDetailsResponse: Decodable {
        let meals: [RecipeDetails]
    }
    
    init() {
        loadMeals()
    }
    
    func getMeals() {
        guard let dessertsURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: dessertsURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(RecipesViewModel.MealsResponse.self, from: data)
                let validMeals = decodedResponse.meals.filter { recipe in
                    !recipe.strMeal.isEmpty && !recipe.id.isEmpty && !recipe.strMealThumb.isEmpty
                }
                
                let sortedMeals = validMeals.sorted { $0.strMeal < $1.strMeal }
                DispatchQueue.main.async {
                    self.meals = sortedMeals
                }
            } catch let error {
                print("Error decoding: ", error)
            }
        }.resume()
    }
    
    func getMealDetails(mealID: String, completion: @escaping (Result<RecipeDetails, Error>) -> Void) {
        guard let mealDetailsURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: mealDetailsURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
            
                let validMealDetails = decodedResponse.meals.filter { mealDetails in
                    !mealDetails.strMeal.isEmpty && !mealDetails.id.isEmpty && !mealDetails.strInstructions.isEmpty && !mealDetails.strMeasures.isEmpty && !mealDetails.strIngredients.isEmpty
                }
                
                if let meal = validMealDetails.first {
                    completion(.success(meal))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No meal found"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func toggleFavorite(for recipe: Recipe) {
        if let index = meals.firstIndex(where: { $0.id == recipe.id }) {
            meals[index].isFavorite.toggle()
            self.meals = self.meals  // Reload the array to trigger view updates
        }
    }

    private func saveMeals() {
        // Save the updated `meals` array to a persistent storage mechanism in this case UserDefaults
        // If I was building a full developed iOS I would opt to use CoreData and create persisted DB objects for all our models
        do {
            let encodedData = try JSONEncoder().encode(meals)
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
                meals = decodedData
            } catch {
                print("Error decoding meals: \(error)")
            }
        }
    }
}
