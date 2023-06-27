//
//  Favorites.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct Favorites: View {
    @EnvironmentObject  private var viewModel:FavoritesViewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                RecipeList(recipes: viewModel.filterData())
            }
            .navigationTitle("Favorites")
                
        }
        .navigationViewStyle(.stack)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environmentObject(HomeViewModel())
    }
}

