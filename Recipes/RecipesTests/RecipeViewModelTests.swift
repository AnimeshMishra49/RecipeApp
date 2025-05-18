//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Testing
@testable import Recipes
@testable import RecipeKit

extension Tag {
    @Tag static var loading: Self
    @Tag static var selection: Self
    @Tag static var failure: Self
    @Tag static var property: Self
    @Tag static var injection: Self
}

@MainActor
struct RecipeViewModelTests {
    /// Verifies that loading recipes sets viewState and selectedRecipe
    @Test("loading recipes sets viewState and selectedRecipe", .tags(.loading), arguments: ["Mock Salad"])
    func testLoadRecipesSetsViewStateAndSelectedRecipe(title: String) async throws {
        // Given a valid recipe provider
        let vm = RecipeViewModel(recipeProvider: MockRecipeService())

        // When loadRecipesAsync() is called
        await vm.loadRecipesAsync()

        // Then viewState should be .loaded and the first recipe should be selected
        #expect(vm.recipes.count == 1)
        #expect(vm.selectedRecipe?.dynamicTitle == title)
        #expect(vm.viewState == .loaded([Recipe.mock]))
    }

    /// Verifies that selecting a recipe updates selectedRecipe
    @Test("selecting a recipe updates selectedRecipe", .tags(.selection), arguments: ["Mock Salad"])
    func testSelectUpdatesSelectedRecipe(title: String) {
        // Given a loaded state with a recipe
        let mock = Recipe.mock
        let vm = RecipeViewModel(recipeProvider: MockRecipeService())
        vm.viewState = .loaded([mock])

        // When select(recipe) is called
        vm.select(mock)

        // Then selectedRecipe should update correctly
        #expect(vm.selectedRecipe?.dynamicTitle == title)
    }

    /// Verifies that viewState is .loading when fetch starts
    @Test("viewState is loading when fetch starts", .tags(.loading))
    func testViewStateIsLoadingInitially() async throws {
        // Given a slow-loading recipe provider
        let vm = RecipeViewModel(recipeProvider: DelayedMockRecipeService())

        // When loadRecipesAsync() is triggered
        let task = Task { await vm.loadRecipesAsync() }
        try await Task.sleep(nanoseconds: 100_000_000)

        // Then viewState should be .loading while data is being fetched
        #expect(vm.viewState == .loading)
        _ = await task.value
    }

    /// Verifies that viewState becomes .failed on error
    @Test("viewState becomes failed on error", .tags(.failure))
    func testViewStateOnFailure() async throws {
        // Given a failing recipe provider
        let vm = RecipeViewModel(recipeProvider: FailingMockRecipeService())

        // When loadRecipesAsync() is called
        await vm.loadRecipesAsync()

        // Then viewState should transition to .failed
        switch vm.viewState {
        case .failed:
            #expect(true)
        default:
            let failure = false
            #expect(failure, "Expected `.failed`, got \(vm.viewState)")
        }
    }

    /// Ensures .recipes returns empty when viewState is not .loaded.
    @Test("recipes returns empty when viewState is not loaded", .tags(.property))
    func testRecipesComputedPropertyReturnsEmptyOnNonLoadedState() {
        // Given a non-loaded state (e.g. .loading, .failed)
        let vm = RecipeViewModel(recipeProvider: MockRecipeService())

        // When accessing the recipes computed property
        // Then it should return an empty array
        vm.viewState = .loading
        #expect(vm.recipes.isEmpty)

        vm.viewState = .failed(RecipeServiceError.fileNotFound)
        #expect(vm.recipes.isEmpty)
    }
    
    /// Ensures that the injected file name and json key are passed correctly to the recipe provider.
    @Test("injected file name and json key are passed correctly to the recipe provider", .tags(.injection), arguments: ["featured.json"], ["top"])
    func testInjectedFileNameAndJsonKeyAreUsed(fileName: String, jsonKey: String) async {
        // Given a viewModel with injected file/key
        let spy = SpyRecipeService()
        let vm = RecipeViewModel(recipeProvider: spy, fileName: fileName, jsonKey: jsonKey)

        // When loadRecipesAsync is called
        await vm.loadRecipesAsync()

        // Then those values should be passed into the service
        // assert after the fact — like which methods were called, with what data.
        #expect(spy.receivedFileName == fileName)
        #expect(spy.receivedKey == jsonKey)
    }
}
