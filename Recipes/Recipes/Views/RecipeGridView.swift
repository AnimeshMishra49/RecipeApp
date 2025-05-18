//
//  RecipeGridView.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//


import SwiftUI
import DesignSystem
import RecipeKit

struct RecipeGridView: View {
    let recipes: [Recipe]
    let selectedID: String?
    let onSelect: (Recipe) -> Void

    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), alignment: .top),
                GridItem(.flexible(), alignment: .top)
            ],
            spacing: AppSpacing.large
        ) {
            ForEach(recipes) { recipe in
                RecipeTileView(recipe: recipe,
                               isSelected: recipe.id == selectedID,
                               tile: .large) {
                    onSelect(recipe)
                }
            }
        }
    }
}

#Preview {
    RecipeGridView(
        recipes: Recipe.mockRecipeList,
        selectedID: Recipe.mockRecipeList.first?.id,
        onSelect: { _ in }
    )
    .environmentObject(OrientationInfo.preview(isPortrait: false))
}
