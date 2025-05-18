//
//  ImageDataCacheTests.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation
import Testing
@testable import RecipeKit

struct ImageDataCacheTests {

    @Test("Should load recipes successfully from JSON file", .tags(.cacheAndData), arguments: ["imageKey"], ["mock image".data(using: .utf8)!])
    func testSaveAndGetImageData(key: String, imageData: Data) async {
        let cache = ImageDataCache()

        await cache.save(data: imageData, forKey: key)
        let result = await cache.get(key: key)

        #expect(result == imageData)
    }

    @Test("Should return nil when data is not found for the key", .tags(.cacheAndData), arguments: ["missing_key"])
    func testGetReturnsNilWhenKeyNotFound(key: String) async {
        let cache = ImageDataCache()
        let result = await cache.get(key: key)

        #expect(result == nil)
    }

    @Test("Should clear all stored data from the cache", .tags(.cacheAndData), arguments: ["clear_image"], [Data("dummy".utf8)])
    func testClearRemovesImageData(key: String, imageData: Data) async {
        let cache = ImageDataCache()
        await cache.save(data: imageData, forKey: key)

        await cache.clear()
        let result = await cache.get(key: key)

        #expect(result == nil)
    }
}
