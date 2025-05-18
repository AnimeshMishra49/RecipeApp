//
//  RecipeTileView.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem
import RecipeKit
import RecipeUI

enum RecipeTileSize {
    case compact
    case large

    var size: CGSize {
        switch self {
        case .compact: return CGSize(width: AppSizing.regular,
                                     height: AppSizing.medium)
        case .large: return CGSize(width: AppSizing.zero,
                                   height: AppSizing.large)
        }
    }
}

struct RecipeTileView: View {
    let recipe: Recipe
    let isSelected: Bool
    let tile: RecipeTileSize
    let onSelect: () -> Void

    @EnvironmentObject var orientation: OrientationInfo

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            AsyncImageView(
                url: URL(string: AppConstants.Doamin.baseURL + recipe.dynamicThumbnail)!,
                alt: recipe.dynamicThumbnailAlt
            )
            .frame(
                width: orientation.isPortrait ? tile.size.width : nil,
                height: tile.size.height
            )
            .cornerRadius(AppCornerRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: AppCornerRadius.medium)
                    .stroke(
                        isSelected ? AppColors.selectedBorder : AppColors.clear,
                        lineWidth: AppSpacing.small
                    )
            )

            Text(recipe.dynamicTitle)
                .captionStyle(isSelected: isSelected)
                .frame(width: orientation.isPortrait ? tile.size.width : nil)
        }
        .padding(AppSpacing.medium)
        .background(isSelected ? AppColors.highlight : AppColors.clear)
        .cornerRadius(AppCornerRadius.regular)
        .onTapGesture {
            onSelect()
        }
    }
}

#Preview {
    RecipeTileView(
        recipe: Recipe.mock,
        isSelected: true,
        tile: .compact,
        onSelect: {}
    )
    .environmentObject(OrientationInfo.preview(isPortrait: false))
}
