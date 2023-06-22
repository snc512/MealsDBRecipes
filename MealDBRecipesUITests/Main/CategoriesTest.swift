//
//  CategoriesTest.swift
//  MealDBRecipesUITests
//
//  Created by Sahil Chhugani on 6/22/23.
//

import XCTest
import SwiftUI

final class CategoriesTest: XCTestCase {
    var view: Categories!

    override func setUpWithError() throws {
        view = Categories()
    }

    override func tearDownWithError() throws {
        view = nil
    }
// Was not able to properly iterate through all navigation links to check that they had values of the different category names
//    func testCategoriesList() {
//        let expectedCategories: [Recipe.Category] = [
//            .breakfast,
//            .soup,
//            .salad,
//            .appetizer,
//            .entree,
//            .dessert,
//            .snack,
//            .drink
//        ]
//
//        let categoriesList = view.body as! List<ForEach<Recipe.Category, NavigationLink<Text, Category>>> // Cast the view hierarchy
//
//        let categoryLabels = categoriesList.children.first!.children.compactMap { $0 as? Text } // Extract category labels
//
//        XCTAssertEqual(categoryLabels.count, expectedCategories.count, "Number of categories doesn't match")
//
//        for (index, label) in categoryLabels.enumerated() {
//            XCTAssertEqual(label.text, expectedCategories[index].rawValue + "s", "Category label doesn't match")
//        }
//    }
}
