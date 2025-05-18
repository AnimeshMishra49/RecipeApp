//
//  RecipesApp.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject var orientation = OrientationInfo()
    
    var body: some Scene {
        WindowGroup {
            RecipeView()
                .environmentObject(orientation)
        }
    }
}
