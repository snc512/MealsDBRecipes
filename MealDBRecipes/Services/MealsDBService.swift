//
//  MealsDBService.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/25/23.
//

import Foundation

class MealsDBService {
    
    struct MealsResponse: Decodable {
        let meals: [Recipe]
    }
    
    struct MealDetailsResponse: Decodable {
        let meals: [RecipeDetails]
    }
    
    
    func getMeals(completion: @escaping (Result<[Recipe], Error>) -> Void)  {
        guard let dessertsURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: dessertsURL) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                let validMeals = decodedResponse.meals.filter { recipe in
                    !recipe.strMeal.isEmpty && !recipe.id.isEmpty && !recipe.strMealThumb.isEmpty
                }
                
                let sortedMeals = validMeals.sorted { $0.strMeal < $1.strMeal }
                completion(.success(sortedMeals))
            } catch let error {
                print("Error decoding: ", error)
                completion(.failure(error))
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
}
