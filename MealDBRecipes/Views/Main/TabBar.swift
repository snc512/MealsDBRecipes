//
//  TabBar.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var recipe:RecipesViewModel
    var body: some View {
        TabView{
            Home()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            Categories()
                .tabItem{
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
            Favorites()
                .tabItem{
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(RecipesViewModel())
    }
}
