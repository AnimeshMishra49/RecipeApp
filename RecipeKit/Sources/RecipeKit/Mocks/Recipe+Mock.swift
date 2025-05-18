//
//  File.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

extension Recipe {
    public static var mock: Recipe {
        Recipe(
            dynamicTitle: "Mock Salad",
            dynamicDescription: "This is a sample mock description.",
            dynamicThumbnail: "/images/mock.jpg",
            dynamicThumbnailAlt: "Mock image of salad",
            recipeDetails: RecipeDetails(
                amountLabel: "Serves",
                amountNumber: 4,
                prepLabel: "Prep",
                prepTime: "10m",
                prepNote: nil,
                cookingLabel: "Cooking",
                cookingTime: "15m"
            ),
            ingredients: [
                Ingredient(ingredient: "1 cup of love"),
                Ingredient(ingredient: "2 tomatoes")
            ]
        )
    }
    
    public static var mockRecipeList: [Recipe] {
        return (1...6).map { index in
            Recipe(
                dynamicTitle: "Recipe \(index)",
                dynamicDescription: "Description for recipe \(index)",
                dynamicThumbnail: "/images/mock.jpg",
                dynamicThumbnailAlt: "Image \(index)",
                recipeDetails: RecipeDetails(
                    amountLabel: "Serves",
                    amountNumber: index + 1,
                    prepLabel: "Prep",
                    prepTime: "\(5 + index)m",
                    prepNote: nil,
                    cookingLabel: "Cooking",
                    cookingTime: "\(10 + index)m"
                ),
                ingredients: [
                    Ingredient(ingredient: "Ingredient \(index).1"),
                    Ingredient(ingredient: "Ingredient \(index).2")
                ]
            )
        }
    }
}
