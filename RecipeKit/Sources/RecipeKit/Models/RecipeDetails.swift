//
//  RecipeDetails.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

public struct RecipeDetails: Codable, Sendable {
    public let amountLabel: String
    public let amountNumber: Int
    public let prepLabel: String
    public let prepTime: String
    public let prepNote: String?
    public let cookingLabel: String
    public let cookingTime: String
}
