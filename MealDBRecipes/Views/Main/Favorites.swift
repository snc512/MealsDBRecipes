//
//  Favorites.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct Favorites: View {
    @EnvironmentObject var viewModel:RecipesViewModel
    
    var favorite_recipes: [Recipe] {
       return viewModel.meals.filter { $0.isFavorite == true }
   }
    
    var body: some View {
        NavigationView{
            ScrollView {
                RecipeList(recipes: favorite_recipes)
            }
            .navigationTitle("Favorites")
                
        }
        .navigationViewStyle(.stack)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environmentObject(RecipesViewModel())
    }
}

