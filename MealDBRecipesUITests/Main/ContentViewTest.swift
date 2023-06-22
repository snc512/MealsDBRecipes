//
//  ContentViewTest.swift
//  MealDBRecipesUITests
//
//  Created by Sahil Chhugani on 6/22/23.
//

import XCTest

final class ContentViewTest: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testContentViewAppearance() throws {
        let tabBarsQuery = app.tabBars
        let tabBarElement = tabBarsQuery.element

        // Wait for the tab bar element to exist
        XCTAssertTrue(tabBarElement.waitForExistence(timeout: 5.0))
    }
    
}
