//
//  MealDBRecipesApp.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

@main
struct MealDBRecipesApp: App {
    
    var recipe = RecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipe)
        }
    }
}
