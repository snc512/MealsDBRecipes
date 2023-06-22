//
//  RecipeTest.swift
//  MealDBRecipesTests
//
//  Created by Sahil Chhugani on 6/20/23.
//

import XCTest
@testable import MealDBRecipes

final class RecipeTest: XCTestCase {
    func testRecipeInitialization() {
        // Given
        let id = "12345"
        let strMeal = "Pancakes"
        let strMealThumb = "https://www.example.com"
        let category = Recipe.Category.breakfast.rawValue
        let isFavorite = false
        
        let recipe = Recipe(id: id, strMeal: strMeal, strMealThumb: strMealThumb, category: category, isFavorite: isFavorite)
        
        XCTAssertEqual(recipe.id, id)
        XCTAssertEqual(recipe.strMeal, strMeal)
        XCTAssertEqual(recipe.strMealThumb, strMealThumb)
        XCTAssertEqual(recipe.category, category)
        XCTAssertEqual(recipe.isFavorite, isFavorite)
    }
    
    func testParsingJSON_ValidData() throws {
       // Given
        let json = """
        {
           "meals": [
               {
                   "strMeal": "Apam balik",
                   "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                   "idMeal": "53049"
               },
               {
                   "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
                   "idMeal": "52893"
               }
           ]
        }
        """
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()

       // When we are parsing data in which only one of the meals is valid
        let response = try decoder.decode(RecipesViewModel.MealsResponse.self, from: jsonData)
        
        let validMeals = response.meals.filter { recipe in
           !recipe.strMeal.isEmpty && !recipe.id.isEmpty && !recipe.strMealThumb.isEmpty
        }

       // Then we will only create one meal after filtering
       XCTAssertEqual(validMeals.count, 1, "Only one valid recipe should be created")
       XCTAssertEqual(validMeals[0].strMeal, "Apam balik", "Valid recipe should have correct name")
       XCTAssertEqual(validMeals[0].strMealThumb, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", "Valid recipe should have correct thumbnail")
       XCTAssertEqual(validMeals[0].id, "53049", "Valid recipe should have correct ID")
   }
    
    func testSuccessRecipeDecoding() throws {
        // Given a valid JSON
        let json = """
        {
            "idMeal": "12345",
            "strMeal": "Pancakes",
            "strMealThumb": "https://www.example.com"
        }
        """
        let jsonData = json.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let recipe = try decoder.decode(Recipe.self, from: jsonData)
        
        // Then we successfuly create a recipe object
        XCTAssertEqual(recipe.id, "12345")
        XCTAssertEqual(recipe.strMeal, "Pancakes")
        XCTAssertEqual(recipe.strMealThumb, "https://www.example.com")
        XCTAssertEqual(recipe.category, Recipe.Category.dessert.rawValue)
        XCTAssertEqual(recipe.isFavorite, false)
    }
    
    func testDecodingErrorHandling() throws {
        // Given an invalid recipe JSON
        let json = """
        {
            "strMeal": "Pancakes",
            "strMealThumb": "https://www.example.com"
        }
        """
        let jsonData = json.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        
        // Then it does not throw an error but instead would be handled by the filtering
        XCTAssertNoThrow(try decoder.decode(Recipe.self, from: jsonData))

    }
    
    func testRecipeEncoding() throws {
        // Given
        let recipe = Recipe(id: "12345", strMeal: "Pancakes", strMealThumb: "https://www.example.com", category: Recipe.Category.breakfast.rawValue, isFavorite: false)
        
        // When
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(recipe)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        // Then
        let expectedJSON = """
        {"idMeal":"12345","strMeal":"Pancakes","strMealThumb":"https:\\/\\/www.example.com"}
        """
        XCTAssertEqual(jsonString, expectedJSON)
    }
}
