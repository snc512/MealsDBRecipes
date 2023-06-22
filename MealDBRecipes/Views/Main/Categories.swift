//
//  Categories.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct Categories: View {
    @EnvironmentObject var recipe:RecipesViewModel

    var body: some View {

        NavigationView {
            List{
                ForEach(Recipe.Category.allCases, id: \.self) { category in
                    NavigationLink {
                        Category(category: category)
                    } label: {
                        Text(category.rawValue + "s")
                    }
                }
            }
                .navigationTitle("Categories")
        
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipesViewModel()

        Categories()
            .environmentObject(recipe)
    }
}

