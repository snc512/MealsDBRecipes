//
//  RecipeCard.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/16/23.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: Recipe
    var body: some View {
        VStack {
            let imageUrlString = recipe.strMealThumb.replacingOccurrences(of: "\\/", with: "/")

            AsyncImage(url: URL(string: imageUrlString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom) {
                        Text(recipe.strMeal)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3)
                            .frame(maxWidth: 136)
                            .padding()
                            
                    }
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight:.infinity)
                    .overlay(alignment: .bottom) {
                        Text(recipe.strMeal)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3)
                            .frame(maxWidth: 136)
                            .padding()
                            
                    }
                
            }
        }
        .frame(width: 160, height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color.gray]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecipesViewModel()
        viewModel.getMeals()
        
        let firstRecipe = viewModel.meals.first ?? Recipe(id: "53049", strMeal: "Apam balik", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/adxcbq1619787919.jpg", category: "Dessert", isFavorite: false)

        return RecipeCard(recipe: firstRecipe)

    }
}
