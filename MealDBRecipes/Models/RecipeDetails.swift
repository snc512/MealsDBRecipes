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
    let strMealThumb: String?
    let strInstructions: String
    let strIngredients: [String]
    let strMeasures: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
        case strInstructions
        case strIngredient
        case strMeasure
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        var meal: String?
        var mealID: String?
        var mealInstructions: String?
        var ingredients: [String]?
        var measurements: [String]?

        
        do {
            meal = try container.decode(String.self, forKey: .strMeal)
            mealID = try container.decode(String.self, forKey: .id)
            mealInstructions = try container.decode(String.self, forKey: .strInstructions)
            ingredients = try Self.decodeDynamicValues(from: decoder, prefix: "strIngredient")
            measurements = try Self.decodeDynamicValues(from: decoder, prefix: "strMeasure")

        } catch let error as DecodingError {
            // Quietly handles when one of the required params is not given
            print("There was a decoding error:", error)
        }
        
        strMeal = meal ?? ""
        id = mealID ?? ""
        strInstructions = mealInstructions ?? ""
        strIngredients = ingredients ?? []
        strMeasures = measurements ?? []
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
    }
    
    private static func decodeDynamicValues(from decoder: Decoder, prefix: String) throws -> [String] {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        // Finds keys that start with prefix and sorts them alphanumerically
        let dynamicKeys = container.allKeys
                .filter { $0.stringValue.starts(with: prefix) }
                .sorted { $0.stringValue.localizedStandardCompare($1.stringValue) == .orderedAscending }
            
        let dynamicValues = try dynamicKeys.compactMap { key -> String? in
            guard let value = try container.decodeIfPresent(String.self, forKey: key),
                    !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return nil
            }
            return value
        }
        
        return dynamicValues
    }
    
    private struct DynamicCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
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
