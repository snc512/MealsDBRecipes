//
//  RecipeCardTest.swift
//  MealDBRecipesTests
//
//  Created by Sahil Chhugani on 6/21/23.
//

import XCTest
@testable import MealDBRecipes
import SwiftUI

class RecipeCardTest: XCTestCase {
    
    func testRecipeCardView() {
        
        let recipe = Recipe(id: "53049", strMeal: "Apam balik", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/adxcbq1619787919.jpg", category: "Dessert", isFavorite: false)
        let recipeCard = RecipeCard(recipe: recipe)
          
        let cardView = recipeCard.body
          
        XCTAssertNotNil(cardView)
    }
    
}


