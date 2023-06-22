//
//  RecipeListTest.swift
//  MealDBRecipesTests
//
//  Created by Sahil Chhugani on 6/21/23.
//

import XCTest
@testable import MealDBRecipes

class RecipeListTests: XCTestCase {

    func testRecipeList_WithRecipes_DisplayCorrectCount() {
        let recipes: [Recipe] = [
            Recipe(id: "1", strMeal: "Recipe 1", strMealThumb: "image1.jpg", category: "Category 1", isFavorite: false),
            Recipe(id: "2", strMeal: "Recipe 2", strMealThumb: "image2.jpg", category: "Category 2", isFavorite: false),
            Recipe(id: "3", strMeal: "Recipe 3", strMealThumb: "image3.jpg", category: "Category 3", isFavorite: false)
        ]
        
        let recipeList = RecipeList(recipes: recipes)
        
        XCTAssertEqual(recipeList.recipes.count, 3, "RecipeList should display correct number of recipes")
    }
    
}
