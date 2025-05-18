//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem
import RecipeKit
import RecipeUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.regular) {
            HeaderSectionView(title: recipe.dynamicTitle,
                               description: recipe.dynamicDescription)

            AsyncImageView(
                url: URL(string: AppConstants.Doamin.baseURL + recipe.dynamicThumbnail)!,
                alt: recipe.dynamicThumbnailAlt
            )

            SummaryRowView(items: [
                .init(title: recipe.recipeDetails.amountLabel, value: "\(recipe.recipeDetails.amountNumber)"),
                .init(title: recipe.recipeDetails.prepLabel, value: recipe.recipeDetails.prepTime),
                .init(title: recipe.recipeDetails.cookingLabel, value: recipe.recipeDetails.cookingTime)
            ])

            BulletListView(
                title: AppConstants.Strings.ingredients,
                items: recipe.ingredients.map { $0.ingredient }
            )
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe.mock)
        .environmentObject(OrientationInfo())
}
