import Testing
import Foundation
@testable import RecipeKit

extension Tag {
    @Tag static var loading: Self
    @Tag static var failure: Self
    @Tag static var property: Self
    @Tag static var cacheAndData: Self
}

struct RecipeServiceTests {

    @Test("Should load recipes successfully from JSON file", .tags(.loading), arguments: ["recipesSample"], ["recipes"])
    func testLoadRecipesFromFile(fileName: String, key: String) async {
        let service = RecipeService()
        let result: Result<[Recipe], RecipeServiceError> = await service.loadRecipes(from: fileName, key: key)
        // should return a non-empty list
        guard case .success(let recipes) = result else {
            let failure = false
            #expect(failure, "Expected success but got failure.")
            return
        }
        #expect(!recipes.isEmpty)
        #expect(!recipes[0].dynamicTitle.isEmpty)
    }

    @Test("missing file returns .fileNotFound error", .tags(.failure), arguments: ["nonexistent"], ["recipes"])
    func testMissingFileReturnsError(fileName: String, key: String) async {
        let service = RecipeService()
        let result: Result<[Recipe], RecipeServiceError> = await service.loadRecipes(from: fileName, key: key)
        
        // should return a .fileNotFound error
        guard case .failure(let error) = result else {
            let failure = false
            #expect(failure, "Expected failure for missing file.")
            return
        }
        #expect(error.localizedDescription == RecipeServiceError.fileNotFound.localizedDescription)
    }

    @Test("malformed JSON returns .decodingFailure error", .tags(.failure), arguments: ["malformed"], ["recipes"])
    func testMalformedJSONReturnsError(fileName: String, key: String) async {
        let service = RecipeService()
        let result: Result<[Recipe], RecipeServiceError> = await service.loadRecipes(from: fileName, key: key)
        
        // should return a .decodingFailure error
        guard case .failure(let error) = result else {
            let failure = false
            #expect(failure, "Expected failure for malformed JSON.")
            return
        }
        #expect(error.localizedDescription == RecipeServiceError.decodingFailure.localizedDescription)
    }

    @Test("missing 'recipes' key returns empty array", .tags(.loading), arguments: ["empty"], ["recipes"])
    func testMissingRecipesKeyReturnsEmptyArray(fileName: String, key: String) async {
        let service = RecipeService()
        let result: Result<[Recipe], RecipeServiceError> = await service.loadRecipes(from: fileName, key: key)
        
        // should return success with empty array
        guard case .success(let recipes) = result else {
            let failure = false
            #expect(failure, "Expected success with empty array.")
            return
        }
        #expect(recipes.isEmpty)
    }

    @Test("fileNotFound error returns correct message", .tags(.property))
    func testFileNotFoundErrorDescription() {
        let error = RecipeServiceError.fileNotFound
        // .fileNotFound returns correct localized description
        #expect(error.localizedDescription == "Recipe file not found.")
    }

    @Test("decodingFailure error returns correct message", .tags(.property))
    func testDecodingFailureErrorDescription() {
        let error = RecipeServiceError.decodingFailure
        // .decodingFailure` returns correct localized description
        #expect(error.localizedDescription == "Failed to decode the recipe JSON.")
    }

    @Test("unknown error returns original error message", .tags(.property))
    func testUnknownErrorDescription() {
        let original = NSError(domain: "TestDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        let error = RecipeServiceError.unknown(original)

        // Then its localizedDescription should return the original message
        #expect(error.localizedDescription == "Something went wrong")
    }
}
