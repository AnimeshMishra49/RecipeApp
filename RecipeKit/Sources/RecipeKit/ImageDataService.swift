//
//  ImageDataService.swift
//  RecipeKit
//
//  Created by Animesh Mishra on 18/5/2025.
//

import Foundation

public final class ImageDataService {
    
    private let cache: ImageDataCacheProvider

    public init(cache: ImageDataCacheProvider = ImageDataCache.shared) {
        self.cache = cache
    }

    public func load(from url: URL) async -> Data? {
        let key = url.absoluteString
        
        if let cachedData = await cache.get(key: key) {
            return cachedData
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            await cache.save(data: data, forKey: key)
            return data
        } catch {
            return nil
        }
    }
}
