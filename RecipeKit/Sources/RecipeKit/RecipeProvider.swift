//
//  RecipeProvider.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation

public protocol RecipeProvider {
    func loadRecipes<T: Codable & Sendable>(from fileName: String, key: String) async -> Result<[T], RecipeServiceError>
}

public final class RecipeService: RecipeProvider {
    
    public init() { }

    public func loadRecipes<T: Codable & Sendable>(from fileName: String, key: String) async -> Result<[T], RecipeServiceError> {
        guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
            return .failure(.fileNotFound)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([String: [T]].self, from: data)
            let recipes = decoded[key] ?? []
            return .success(recipes)
        } catch is DecodingError {
            return .failure(.decodingFailure)
        } catch {
            return .failure(.unknown(error))
        }
    }
}
