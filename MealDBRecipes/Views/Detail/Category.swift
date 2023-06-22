//
//  Category.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/19/23.
//

import SwiftUI

struct Category: View {
    @EnvironmentObject var viewModel:RecipesViewModel

    var category: Recipe.Category
    
    var recipes: [Recipe] {
       return viewModel.meals.filter { $0.category == category.rawValue }
   }
    
    var body: some View {
        ScrollView {
            RecipeList(recipes: recipes)
        }
        .navigationTitle(category.rawValue + "s")
    }
}

struct Category_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipesViewModel()
        
        Category(category: Recipe.Category.dessert)
            .environmentObject(recipe)

    }
}
