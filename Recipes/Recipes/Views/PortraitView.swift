//
//  PortraitView.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem
import RecipeKit
import RecipeUI

struct PortraitView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    Color.clear
                        .frame(height: AppSpacing.zero)
                        .id(AppConstants.Identifier.top)

                    if let recipe = viewModel.selectedRecipe {
                        RecipeDetailView(recipe: recipe)
                            .id(recipe.id)
                    }

                    Text(AppConstants.Strings.allRecipesTitle)
                        .sectionHeaderStyle()
                    
                    HorizontalTileScrollView(items: viewModel.recipes,
                                             selectedID: viewModel.selectedRecipe?.id) { recipe, isSelected in
                        RecipeTileView(recipe: recipe,
                                       isSelected: isSelected,
                                       tile: .compact,
                                       onSelect: {
                            viewModel.select(recipe)
                            scrollToTop(using: proxy)
                        })
                    }
                }
                .padding()
            }
        }
    }
    
    private func scrollToTop(using proxy: ScrollViewProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.6)) {
                proxy.scrollTo(AppConstants.Identifier.top, anchor: .top)
            }
        }
    }
}


#Preview {
    PortraitView(viewModel: {
        let vm = RecipeViewModel()
        vm.viewState = .loaded(Recipe.mockRecipeList) 
        vm.selectedRecipe = Recipe.mockRecipeList.first
        return vm
    }())
    .environmentObject(OrientationInfo.preview(isPortrait: true))
}
