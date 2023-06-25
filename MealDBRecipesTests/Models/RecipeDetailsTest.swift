//
//  RecipeDetailsTest.swift
//  MealDBRecipesTests
//
//  Created by Sahil Chhugani on 6/20/23.
//

import XCTest
@testable import MealDBRecipes


final class RecipeDetailsTest: XCTestCase {
    
    func testRecipeDetailsInitialization() {
        let id = "12345"
        let strMeal = "Pancakes"
        let strMealThumb = "https://www.example.com/pancakes.jpg"
        let strInstructions = "Mix all ingredients and cook on a griddle."
        let strIngredients = ["Flour", "Milk", "Eggs"]
        let strMeasures = ["1 cup", "1/2 cup", "2"]
        
        let recipeDetails = RecipeDetails(id: id, strMeal: strMeal, strMealThumb: strMealThumb, strMeasures: strMeasures, strInstructions: strInstructions, strIngredients: strIngredients)
        
        XCTAssertEqual(recipeDetails.id, id)
        XCTAssertEqual(recipeDetails.strMeal, strMeal)
        XCTAssertEqual(recipeDetails.strMealThumb, strMealThumb)
        XCTAssertEqual(recipeDetails.strInstructions, strInstructions)
        XCTAssertEqual(recipeDetails.strIngredients, strIngredients)
        XCTAssertEqual(recipeDetails.strMeasures, strMeasures)
    }
    
    func testSuccessRecipeDetailsDecoding() throws {
            // Given a valid JSON for recipe details
            let json = """
            {
                "idMeal": "98765",
                "strMeal": "Pizza",
                "strMealThumb": "https://www.example.com/pizza.jpg",
                "strInstructions": "Prepare the dough and add your favorite toppings.",
                "strIngredient1": "Flour",
                "strMeasure1": "2 cups",
                "strIngredient2": "Tomato sauce",
                "strMeasure2": "1 cup",
                "strIngredient3": "Cheese",
                "strMeasure3": "200g"
            }
            """
            let jsonData = json.data(using: .utf8)!
            
            // Then we create a proper Recipe Details object
            let decoder = JSONDecoder()
            let recipeDetails = try decoder.decode(RecipeDetails.self, from: jsonData)
            
            XCTAssertEqual(recipeDetails.id, "98765")
            XCTAssertEqual(recipeDetails.strMeal, "Pizza")
            XCTAssertEqual(recipeDetails.strMealThumb, "https://www.example.com/pizza.jpg")
            XCTAssertEqual(recipeDetails.strInstructions, "Prepare the dough and add your favorite toppings.")
            XCTAssertEqual(recipeDetails.strIngredients, ["Flour", "Tomato sauce", "Cheese"])
            XCTAssertEqual(recipeDetails.strMeasures, ["2 cups", "1 cup", "200g"])
        }
    
    func testFetchingMealDetails_ValidData() {
        // Given
        let json = """
        {
           "meals": [
                {
                    "idMeal": "98765",
                    "strMeal": "Pizza",
                    "strMealThumb": "https://www.example.com/pizza.jpg",
                    "strInstructions": "Prepare the dough and add your favorite toppings.",
                    "strIngredient1": "Flour",
                    "strMeasure1": "2 cups",
                    "strIngredient2": "Tomato sauce",
                    "strMeasure2": "1 cup",
                    "strIngredient3": "Cheese",
                    "strMeasure3": "200g"
                },
                {
                    "idMeal": "98765",
                    "strMeal": "Recipe",
                    "strMealThumb": "https://www.example.com/pizza.jpg",
                    "strInstructions": "Prepare the dough and add your favorite toppings.",
                    "strIngredient1": "Flour"
                }
            ]
        }
        """
        let jsonData = json.data(using: .utf8)!

        
        let decoder = JSONDecoder()
        
        // When
        let decodedResponse = try! decoder.decode(RecipesViewModel.MealDetailsResponse.self, from: jsonData)
        let validMealDetails = decodedResponse.meals.filter { mealDetails in
            !mealDetails.strMeal.isEmpty && !mealDetails.id.isEmpty && !mealDetails.strInstructions.isEmpty && !mealDetails.strMeasures.isEmpty && !mealDetails.strIngredients.isEmpty
        }
        XCTAssertEqual(validMealDetails.count, 1, "Only one valid recipe details object should be created")
    
    }
    
    
    
    func testDecodingErrorHandling() throws {
       // Given an incomplete json object for a RecipeDetail
        let json = """
        {
           "idMeal": "12345",
           "strInstructions": "Some instructions",
           "strIngredient1": "Ingredient 1",
           "strMeasure1": "Measure 1"
        }
        """
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        
        // Then it does not throw an error but instead would be handled by the filtering
        XCTAssertNoThrow(try decoder.decode(RecipeDetails.self, from: jsonData))

    }
}
