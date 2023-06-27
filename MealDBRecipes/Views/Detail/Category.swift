//
//  Category.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/19/23.
//

import SwiftUI

struct Category: View {
    @EnvironmentObject  private var viewModel:CategoryViewModel

    var category: Recipe.Category
    
    var body: some View {
        ScrollView {
            RecipeList(recipes: viewModel.filterData(category: category.rawValue))
        }
        .navigationTitle(category.rawValue + "s")
    }
}

struct Category_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = HomeViewModel()
        
        Category(category: Recipe.Category.dessert)
            .environmentObject(recipe)

    }
}
