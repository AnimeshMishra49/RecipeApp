//
//  RecipeServiceError.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation

public enum RecipeServiceError: Error, LocalizedError {
    case fileNotFound
    case decodingFailure
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Recipe file not found."
        case .decodingFailure:
            return "Failed to decode the recipe JSON."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
