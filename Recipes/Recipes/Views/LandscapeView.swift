//
//  LandscapeView.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem
import RecipeKit

struct LandscapeView: View {
    @ObservedObject var viewModel: RecipeViewModel

    var body: some View {
        ScrollView {
            VStack {
                Text(AppConstants.Strings.allRecipesTitle)
                    .sectionHeaderStyle()
                    .multilineTextAlignment(.center)
                
                RecipeGridView(recipes: viewModel.recipes,
                               selectedID: viewModel.selectedRecipe?.id,
                               onSelect: { viewModel.select($0) })
            }
            .padding()
        }
    }
}

#Preview {
    LandscapeView(viewModel: {
        let vm = RecipeViewModel()
        vm.viewState = .loaded(Recipe.mockRecipeList) 
        vm.selectedRecipe = Recipe.mockRecipeList.first
        return vm
    }())
    .environmentObject(OrientationInfo.preview(isPortrait: false))
}
