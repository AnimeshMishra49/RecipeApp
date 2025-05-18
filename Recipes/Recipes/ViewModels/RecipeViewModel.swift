//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import RecipeKit

@MainActor
class RecipeViewModel: ObservableObject {
    // MARK: - Dependencies
    
    private let recipeProvider: RecipeProvider
    private let fileName: String
    private let jsonKey: String

    // MARK: - Published Properties
    
    @Published var viewState: RecipeViewState = .loading
    @Published var selectedRecipe: Recipe?

    // MARK: - Initializer

    init(recipeProvider: RecipeProvider = RecipeService(),
         fileName: String = AppConstants.File.recipesJSON,
         jsonKey: String = AppConstants.Identifier.recipes) {
        self.recipeProvider = recipeProvider
        self.fileName = fileName
        self.jsonKey = jsonKey
    }

    // MARK: - Computed Properties
    
    /// Returns the list of recipes only if data is loaded successfully.
    var recipes: [Recipe] {
        if case .loaded(let recipes) = viewState {
            return recipes
        }
        return []
    }

    // MARK: - User Actions
    
    /// Updates the selected recipe for detail view display.
    func select(_ recipe: Recipe) {
        selectedRecipe = recipe
    }

    /// Triggers async recipe loading from bundled file.
    func loadRecipes() {
        Task {
            await loadRecipesAsync()
        }
    }

    /// Used for pull-to-refresh functionality.
    func refreshRecipes() async {
        await loadRecipesAsync()
    }

    // MARK: - API Call
    
    /// Loads recipes from JSON file and updates view state.
    func loadRecipesAsync() async {
        viewState = .loading
        let result: Result<[Recipe], RecipeServiceError> = await recipeProvider.loadRecipes(from: fileName,
                                                                                            key: jsonKey)
        switch result {
        case .success(let recipes):
            selectedRecipe = recipes.first
            viewState = .loaded(recipes)
        case .failure(let error):
            viewState = .failed(error)
        }
    }
}
