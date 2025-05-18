//
//  RecipeViewState.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//


import Foundation
import RecipeKit

public enum RecipeViewState: Equatable {
    case loading
    case loaded([Recipe])
    case failed(Error)

    public static func == (lhs: RecipeViewState, rhs: RecipeViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.loaded, .loaded), (.failed, .failed):
            return true
        default:
            return false
        }
    }
}