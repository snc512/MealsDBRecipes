//
//  Home.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView{
            ScrollView {
                RecipeList(recipes: homeViewModel.meals)
            }
            .navigationTitle("All Recipes")
                
        }
        .navigationViewStyle(.stack)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(HomeViewModel())
    }
}
