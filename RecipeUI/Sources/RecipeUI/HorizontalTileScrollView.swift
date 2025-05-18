//
//  HorizontalTileScrollView.swift
//  RecipeUI
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem
import RecipeKit

public struct HorizontalTileScrollView<Item: Identifiable, TileView: View>: View {
    public let items: [Item]
    public let selectedID: Item.ID?
    public let tileView: (Item, Bool) -> TileView
    
    public init(
        items: [Item],
        selectedID: Item.ID?,
        @ViewBuilder tileView: @escaping (Item, Bool) -> TileView
    ) {
        self.items = items
        self.selectedID = selectedID
        self.tileView = tileView
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: AppSpacing.large) {
                ForEach(items) { item in
                    tileView(item, item.id == selectedID)
                }
            }
        }
    }
}


#Preview {
    HorizontalTileScrollView(
        items: Recipe.mockRecipeList,
        selectedID: Recipe.mockRecipeList.first?.id) { recipe, isSelected in
        VStack(spacing: AppSpacing.small) {
            Rectangle()
                .fill(isSelected ? AppColors.selectedBorder : AppColors.primary)
                .frame(width: AppSizing.regular, height: AppSizing.medium)
                .cornerRadius(AppCornerRadius.medium)

            Text(recipe.dynamicTitle)
                .font(AppTypography.caption)
                .foregroundColor(isSelected ? AppColors.secondaryText : AppColors.primary)
        }
        .padding(AppSpacing.medium)
        .background(isSelected ? AppColors.highlight : AppColors.clear)
        .cornerRadius(AppCornerRadius.regular)
        .shadow(radius: AppSpacing.small)
    }
    .padding(AppSpacing.large)
}
