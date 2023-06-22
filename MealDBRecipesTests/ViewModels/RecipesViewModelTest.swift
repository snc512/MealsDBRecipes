//
//  RecipesViewModelTest.swift
//  MealDBRecipesTests
//
//  Created by Sahil Chhugani on 6/21/23.
//

import XCTest
@testable import MealDBRecipes


final class RecipesViewModelTest: XCTestCase {
    var viewModel: RecipesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RecipesViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    
    func testGetMeals() {
        let expectation = XCTestExpectation(description: "Fetch meals expectation")
        
        viewModel.getMeals()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(!self.viewModel.meals.isEmpty, "Meals array should not be empty")
            let meals = self.viewModel.meals.map {meal in
                return meal.strMeal}
            let sorted_meals = self.viewModel.meals.sorted{ $0.strMeal < $1.strMeal}.map {meal in
                return meal.strMeal}
            XCTAssertEqual(sorted_meals, meals, "Meals are sorted alphabetically")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testSuccessGetMealDetails() {
        let expectation = XCTestExpectation(description: "Fetch meal details expectation")
        let mealID = "53049"
        
        viewModel.getMealDetails(mealID: mealID) { result in
            switch result {
            case .success(let mealDetails):
                XCTAssertNotNil(mealDetails, "Meal details should not be nil")
            case .failure(let error):
                XCTFail("Fetching meal details failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testToggleFavorite() {
        let recipe = Recipe(id: "123", strMeal: "Pancakes", strMealThumb: "https://www.example.com", category: "Dessert", isFavorite: false)
        viewModel.meals = [recipe]
        
        viewModel.toggleFavorite(for: recipe)
        
        XCTAssertTrue(viewModel.meals.first?.isFavorite == true, "Recipe should be marked as favorite")
    }
}
