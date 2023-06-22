//
//  TabBarTest.swift
//  MealDBRecipesUITests
//
//  Created by Sahil Chhugani on 6/22/23.
//

import XCTest
@testable import MealDBRecipes

class TabBarUITest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testTabBarSelection() throws {
        let homeTabButton = app.tabBars.buttons["Home"]
        let categoriesTabButton = app.tabBars.buttons["Categories"]
        let favoritesTabButton = app.tabBars.buttons["Favorites"]

        // Select the "Categories" tab
        categoriesTabButton.tap()

        // Assert that the "Categories" tab is selected
        XCTAssertTrue(categoriesTabButton.isSelected)
        XCTAssertFalse(homeTabButton.isSelected)
        XCTAssertFalse(favoritesTabButton.isSelected)

        // Select the "Favorites" tab
        favoritesTabButton.tap()

        // Assert that the "Favorites" tab is selected
        XCTAssertTrue(favoritesTabButton.isSelected)
        XCTAssertFalse(homeTabButton.isSelected)
        XCTAssertFalse(categoriesTabButton.isSelected)

        // Select the "Home" tab
        homeTabButton.tap()

        // Assert that the "Home" tab is selected
        XCTAssertTrue(homeTabButton.isSelected)
        XCTAssertFalse(categoriesTabButton.isSelected)
        XCTAssertFalse(favoritesTabButton.isSelected)
    }
}
