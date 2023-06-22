//
//  RecipeView.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/16/23.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "largecircle.fill.circle" : "circle")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(isChecked ? .blue : .gray)
            .onTapGesture {
                isChecked.toggle()
            }
    }
}

struct RecipeView: View {
    var recipe: Recipe
    var mealID: String
    @State private var mealDetails: RecipeDetails?
    @State private var isChecked: [Bool] = Array(repeating: false, count: 20)
    
    var isFavorite: Bool {
         meals.meals.first { $0.id == recipe.id }?.isFavorite ?? false
     }
    
    @EnvironmentObject var meals:RecipesViewModel

    var body: some View {
        ScrollView {
            let imageUrlString = recipe.strMealThumb.replacingOccurrences(of: "\\/", with: "/")

            AsyncImage(url: URL(string: imageUrlString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight:.infinity)
            }
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color.gray]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 30) {
                if let mealDetails = mealDetails {
                    
                    HStack {
                        
                        Button(action: {
                            meals.toggleFavorite(for: recipe)
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                        }
                        Text(mealDetails.strMeal)
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                        .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 30) {
                        if !mealDetails.strIngredients.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Ingredients: ")
                                    .font(.headline)
                                
                                ForEach(0..<mealDetails.strIngredients.count, id: \.self) { index in
                                    HStack {
                                        Checkbox(isChecked: $isChecked[index])
                                        Text("\(mealDetails.strIngredients[index]) - \(mealDetails.strMeasures[index])")
                                            .font(.body)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                        }
                        
                        if !mealDetails.strInstructions.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Instructions: ")
                                    .font(.headline)
                                Text(mealDetails.strInstructions)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("Loading meal details...")
                }
            }
            .padding()
        }
        .onAppear {
            self.getMealDetails(mealID: mealID)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func getMealDetails(mealID: String) {
        meals.getMealDetails(mealID: mealID) { result in
            switch result {
            case .success(let mealDetails):
                self.mealDetails = mealDetails
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let firstRecipe = Recipe(id: "53049", strMeal: "Apam balik", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/adxcbq1619787919.jpg", category: "Dessert", isFavorite: false)
        
        let sampleDetails = RecipeDetails(id: "", strMeal: "Apam balik", strMealThumb: "", strMeasures: ["200ml","60ml","2","1600g","3 tsp","1/2 tsp","25g","45g","3 tbs"], strInstructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.", strIngredients: ["Milk","Oil","Eggs","Flour","Baking Powder","Salt", "Unsalted Butter","Sugar","Peanut Butter"])

        return RecipeView(recipe: firstRecipe, mealID: "53049")
            .environmentObject(RecipesViewModel())
    }
}
