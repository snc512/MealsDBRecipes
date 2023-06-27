//
//  TabBar.swift
//  MealDBRecipes
//
//  Created by Sahil Chhugani on 6/15/23.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var homeViewModel:HomeViewModel
    var body: some View {
        TabView{
            Home()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            Categories()
                .environmentObject(CategoryViewModel(homeViewModel: homeViewModel))
                .tabItem{
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
            Favorites()
                .environmentObject(FavoritesViewModel(homeViewModel: homeViewModel))
                .tabItem{
                    Label("Favorites", systemImage: "heart")
                }

        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(HomeViewModel())
    }
}
