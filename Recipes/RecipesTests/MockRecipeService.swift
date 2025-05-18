//
//  MockRecipeService.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation
@testable import RecipeKit

/// Mock implementation of `RecipeProvider` that always returns a mock recipe.
struct MockRecipeService: RecipeProvider {
    func loadRecipes<T: Codable & Sendable>(from fileName: String, key: String) async -> Result<[T], RecipeServiceError> {
        guard let mock = Recipe.mock as? T else {
            return .failure(.decodingFailure)
        }
        return .success([mock])
    }
}

/// Mock that simulates a failure due to file not being found.
struct FailingMockRecipeService: RecipeProvider {
    func loadRecipes<T: Codable & Sendable>(from fileName: String, key: String) async -> Result<[T], RecipeServiceError> {
        return .failure(.fileNotFound)
    }
}

/// Mock that introduces a slight delay before returning success.
struct DelayedMockRecipeService: RecipeProvider {
    func loadRecipes<T: Codable & Sendable>(from fileName: String, key: String) async -> Result<[T], RecipeServiceError> {
        try? await Task.sleep(nanoseconds: 200_000_000) // 200ms delay
        guard let mockRecipe = Recipe.mock as? T else {
            return .failure(.decodingFailure)
        }
        return .success([mockRecipe])
    }
}

/// Spy that captures the parameters passed to `loadRecipes`.
final class SpyRecipeService: RecipeProvider {
    var receivedFileName: String?
    var receivedKey: String?

    func loadRecipes<T: Codable & Sendable>(from file: String, key: String) async -> Result<[T], RecipeServiceError> {
        receivedFileName = file
        receivedKey = key
        guard let mock = Recipe.mock as? T else {
            return .failure(.decodingFailure)
        }
        return .success([mock])
    }
}
