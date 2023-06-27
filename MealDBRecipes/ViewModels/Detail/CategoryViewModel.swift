//
//  CategoryViewModel.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/25/23.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published private var homeViewModel: HomeViewModel

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }

    func filterData(category: String) -> [Recipe] {
         return homeViewModel.meals.filter { $0.category == category }
     }
}
