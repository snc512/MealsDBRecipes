MealsDBRecipe App
The MealsDBRecipe App is a simple iOS application that allows users to browse and discover various recipes. It leverages the MealDB API to fetch recipe data and present it in a user-friendly interface. Users can explore different categories of recipes, view recipe details, and mark recipes as favorites. 

Features:
 - Browse Recipes: Explore a variety of recipes categorized by meal types.
 - Recipe Details: View detailed information about a recipe, including ingredients and instructions.
 - Mark Favorites: Save recipes as favorites for easy access.

Technology Stack:
- Swift
- SwiftUI
- URLSession
- XCTest

Getting Started: 
- Clone the repository.
- Open the project in Xcode.
- Build and run the app using the iOS Simulator or a connected iOS device.

Future Ideas:
- Add more detailed/fully fleshed UI/Feature tests 
- If I were to add many more api calls or access a more secure API, I may consider creating a "Services" directory with the first being a MealDBAPIService for a single isolated location for configurations.
- Being able to create your own recipes should be possible + you can save them in some cloud data storage
- If I were to introduce this last step, I would also want there to be users, and then would need to use a formal DB (easiest would be relational with Core Data)
- With users, there would also be authentication and I believe the easiest way to introduce a simple SSO solution for iOS apps would be via Firebase
- An AI feature, where you take a photo of ingredients, it then is able to detect how much of each ingredient you have, and then tells you recipe options would be the most fun :)

Demo: 
https://github.com/snc512/MealsDBRecipes/assets/23483902/f906ca7b-3d39-4143-828b-9925c861a032

