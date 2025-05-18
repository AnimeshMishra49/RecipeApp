//
//  ImageDataServiceTests.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation
import Testing
@testable import RecipeKit

struct ImageDataServiceTests {

    @Test("Should return cached image data if already available", .tags(.cacheAndData), arguments: ["https://mock.com/image.png"], ["cached image".data(using: .utf8)!])
    func testReturnsCachedDataIfPresent(key: String, dummyData: Data) async {
        let mockCache = MockImageDataCache()
        await mockCache.save(data: dummyData, forKey: key)

        let service = ImageDataService(cache: mockCache)
        let result = await service.load(from: URL(string: key)!)

        #expect(result == dummyData)
    }
}

final actor MockImageDataCache: ImageDataCacheProvider {
    private var store: [String: Data] = [:]

    func get(key: String) async -> Data? {
        store[key]
    }

    func save(data: Data, forKey key: String) async {
        store[key] = data
    }

    func clear() async {
        store.removeAll()
    }
}
