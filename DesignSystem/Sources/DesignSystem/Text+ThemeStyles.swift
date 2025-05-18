//
//  File.swift
//  DesignSystem
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI

public extension Text {
    func largeHeaderStyle() -> some View {
        self.font(AppTypography.largeHeader)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    func sectionHeaderStyle() -> some View {
        self.font(AppTypography.sectionHeader)
            .padding(.top, AppSpacing.medium)
    }

    func ingredientStyle() -> some View {
        self.font(AppTypography.bodyText)
            .padding(.horizontal, AppSpacing.large)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    func captionStyle(isSelected: Bool = false) -> some View {
        self.font(AppTypography.caption)
            .lineLimit(3)
            .multilineTextAlignment(.center)
            .foregroundColor(isSelected ? AppColors.primary : .primary)
    }
}
