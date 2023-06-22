//
//  MealDBRecipesUITests.swift
//  MealDBRecipesUITests
//
//  Created by Sahil Chhugani on 6/15/23.
//

import XCTest

final class MealDBRecipesUITests: XCTestCase {
    var app: XCUIApplication!

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
