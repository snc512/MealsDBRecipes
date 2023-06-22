//
//  ContentView.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:RecipesViewModel
    var body: some View {
        TabBar()
            .onAppear{
                viewModel.getMeals()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
    }
}
