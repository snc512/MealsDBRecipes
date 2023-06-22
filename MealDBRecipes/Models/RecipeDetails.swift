//
//  RecipeDetails.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/20/23.
//

import Foundation

class RecipeDetails: Identifiable, Decodable {
    let id: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredients: [String]
    let strMeasures: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
        case strInstructions
        
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    required init (from decoder: Decoder) throws {
        
        var ingredients: [String] = []
        var measures: [String] = []

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Required response values for each meal detail object when decoding from MealDBAPI
        // idMeal, strMeal, strInstructions, strIngredient1, strMeasure1
        
        var meal: String?
        var mealID: String?
        var mealInstructions: String?
        var mealIngredient1: String?
        var mealMeasure1: String?

        
        do {
            meal = try container.decode(String.self, forKey: .strMeal)
            mealID = try container.decode(String.self, forKey: .id)
            mealInstructions = try container.decode(String.self, forKey: .strInstructions)
            mealIngredient1 = try container.decode(String.self, forKey: .strIngredient1)
            mealMeasure1 = try container.decode(String.self, forKey: .strMeasure1)
        } catch let error as DecodingError {
            // Quietly handles when one of the required params is not given
            print("There was a decoding error:", error)
        }
        
        self.strMeal = meal ?? ""
        self.id = mealID ?? ""
        self.strInstructions = mealInstructions ?? ""
        ingredients.append(mealIngredient1 ?? "")
        measures.append(mealMeasure1 ?? "")

     
        // The rest of these keys are not required
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb) ?? ""
        
        for ingredientIndex in 2...20 {
            if let ingredientKey = CodingKeys(stringValue: "strIngredient\(ingredientIndex)"),
                let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey) {
                if (ingredient != "") {
                    ingredients.append(ingredient)
                }
            }
        }
        strIngredients = ingredients
        for measureIndex in 2...20 {
            if let measureKey = CodingKeys(stringValue: "strMeasure\(measureIndex)"),
                    let measure = try container.decodeIfPresent(String.self, forKey: measureKey) {
                if (measure != "") {
                    measures.append(measure)
                }
            }
        }
        strMeasures = measures
    }
    
    init(id: String, strMeal: String, strMealThumb: String, strMeasures: [String], strInstructions: String, strIngredients: [String]) {
        self.id = id
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strMeasures = strMeasures
        self.strInstructions = strInstructions
        self.strIngredients = strIngredients
    }
}
