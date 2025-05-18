//
//  HeaderSectionView.swift
//  RecipeUI
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem

public struct HeaderSectionView: View {
    public let title: String
    public let description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.regular) {
            Text(title)
                .largeHeaderStyle()
                .padding(.horizontal, AppSpacing.medium)
                .accessibilityAddTraits(.isHeader)

            Text(description)
                .ingredientStyle()
        }
    }
}

#Preview {
    HeaderSectionView(title: "Mock Salad",
                       description: "A healthy green salad.")
}
