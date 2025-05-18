//
//  ImageDataCacheProvider.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation

public protocol ImageDataCacheProvider: Sendable {
    func get(key: String) async -> Data?
    func save(data: Data, forKey key: String) async
    func clear() async
}

public actor ImageDataCache: ImageDataCacheProvider {
    private var memoryCache = [String: Data]()

    public init() {}
    
    public func get(key: String) async -> Data? {
        memoryCache[key]
    }

    public func save(data: Data, forKey key: String) async {
        memoryCache[key] = data
    }

    public func clear() async {
        memoryCache.removeAll()
    }
}
