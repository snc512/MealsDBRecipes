//
//  Recipe.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//
import Foundation

class Recipe: Identifiable, Encodable, Decodable {
    let id: String
    let strMeal: String
    let strMealThumb: String
    let category: Category.RawValue
    var isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
    
    enum Category: String, CaseIterable {
        case breakfast = "Breakfast"
        case soup = "Soup"
        case salad = "Salad"
        case appetizer = "Appetizer"
        case entree = "Entree"
        case dessert = "Dessert"
        case snack = "Snack"
        case drink = "Drink"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Required response values for each meal when decoding from MealDBAPI
        var meal: String?
        var mealThumb: String?
        var mealID: String?
        
        do {
            meal = try container.decode(String.self, forKey: .strMeal)
            mealThumb = try container.decode(String.self, forKey: .strMealThumb)
            mealID = try container.decode(String.self, forKey: .id)
        } catch let error as DecodingError {
            // Quietly handles when one of the required params is not given 
            print("There was a decoding error:", error)
        }
        
        self.strMeal = meal ?? ""
        self.strMealThumb = mealThumb ?? ""
        self.id = mealID ?? ""
        self.category = "Dessert"
        self.isFavorite = false
    }

    
    init(id: String, strMeal: String, strMealThumb: String, category: Category.RawValue, isFavorite: Bool) {
        self.id = id
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.category = category
        self.isFavorite = isFavorite
    }
}
