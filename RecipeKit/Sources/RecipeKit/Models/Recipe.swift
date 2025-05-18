//
//  Recipe.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

public struct Recipe: Codable, Identifiable, Sendable {
    public var id: String { dynamicTitle }
    public let dynamicTitle: String
    public let dynamicDescription: String
    public let dynamicThumbnail: String
    public let dynamicThumbnailAlt: String
    public let recipeDetails: RecipeDetails
    public let ingredients: [Ingredient]
}
