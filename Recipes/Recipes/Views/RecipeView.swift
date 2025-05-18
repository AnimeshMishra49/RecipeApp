//
//  RecipeView.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//


import SwiftUI
import DesignSystem
import RecipeKit
import RecipeUI

struct RecipeView: View {
    @StateObject var viewModel = RecipeViewModel()
    @EnvironmentObject var orientation: OrientationInfo
    
    var shouldAutoLoad: Bool = true

    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                ProgressView(AppConstants.Strings.loadingRecipes)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded:
                if orientation.isPortrait {
                    PortraitView(viewModel: viewModel)
                } else {
                    LandscapeView(viewModel: viewModel)
                }

            case .failed:
                VStack(spacing: AppSpacing.large) {
                    HeaderSectionView(title: "Please try again later.",
                                      description: "Failed to load recipes.")
                    Button("Retry") {
                        viewModel.loadRecipes()
                    }
                    .padding(.top, AppSpacing.medium)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .refreshable {
            await viewModel.refreshRecipes()
        }
        .onAppear {
            if shouldAutoLoad {
                viewModel.loadRecipes()
            }
        }
    }
}

#Preview("Loading") {
    RecipeView(viewModel: {
        let vm = RecipeViewModel()
        vm.viewState = .loading
        return vm
    }(), shouldAutoLoad: false)
    .environmentObject(OrientationInfo.preview(isPortrait: true))
}

#Preview("Loaded") {
    RecipeView(viewModel: {
        let vm = RecipeViewModel()
        vm.viewState = .loaded(Recipe.mockRecipeList)
        vm.selectedRecipe = Recipe.mock
        return vm
    }(), shouldAutoLoad: false)
    .environmentObject(OrientationInfo.preview(isPortrait: true))
}

#Preview("Failed") {
    RecipeView(viewModel: {
        let vm = RecipeViewModel()
        vm.viewState = .failed(
            NSError(domain: "TestError", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Mock failure for preview"
            ])
        )
        return vm
    }(), shouldAutoLoad: false)
    .environmentObject(OrientationInfo.preview(isPortrait: true))
}
