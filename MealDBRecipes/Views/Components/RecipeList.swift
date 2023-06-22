//
//  RecipeList.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/16/23.
//

import SwiftUI

struct RecipeList: View {
    var recipes: [Recipe]
    @EnvironmentObject var viewModel: RecipesViewModel
    @State private var selectedRecipe: Recipe?

    var body: some View {
        VStack{
            HStack {
                Text("\(recipes.count) \(recipes.count > 1 ? "recipes" : "recipe")")
                    .font(.headline)
                    .fontWeight(.medium)
                .opacity(0.7)
                
                Spacer()
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                ForEach(recipes) { recipe in
                    Button(action: {
                        selectedRecipe = recipe
                    }) {
                        RecipeCard(recipe: recipe)
                            .onDisappear {
                                selectedRecipe = nil  // Reset the selected recipe when dismissed
                            }
                    }
                }
            }
                .padding(.top)
        }
            .sheet(item: $selectedRecipe) { recipe in
                RecipeView(recipe: recipe, mealID: recipe.id)
                    .onDisappear {
                        selectedRecipe = nil  // Reset the selected recipe when the sheet is dismissed
                    }
            }
        .padding(.horizontal)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecipesViewModel()
        viewModel.getMeals()
        
        let recipes: [Recipe] = [
                   Recipe(id: "53049", strMeal: "Apam balik", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/adxcbq1619787919.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52893", strMeal: "Apple & Blackberry Crumble", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/xvsurr1511719182.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52768", strMeal: "Apple Frangipan Tart", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/wxywrq1468235067.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52767", strMeal: "Bakewell tart", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/wyrqqq1468233628.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52855", strMeal: "Banana Pancakes", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/sywswr1511383814.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52928", strMeal: "BeaverTails", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/ryppsv1511815505.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52891", strMeal: "Blackberry Fool", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/rpvptu1511641092.jpg", category: "Dessert", isFavorite: false),
                   
                   Recipe(id: "52792", strMeal: "Bread and Butter Pudding", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/xqwwpy1483908697.jpg", category: "Dessert", isFavorite: false),
                   
                   Recipe(id: "52961", strMeal: "Budino Di Ricotta", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/1549542877.jpg", category: "Dessert", isFavorite: false),
                   Recipe(id: "52923", strMeal: "Canadian Butter Tarts", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/wpputp1511812960.jpg", category: "Dessert", isFavorite: false),
               ]

        return ScrollView {
            RecipeList(recipes: recipes)
                .environmentObject(viewModel)
       }
    }
}
