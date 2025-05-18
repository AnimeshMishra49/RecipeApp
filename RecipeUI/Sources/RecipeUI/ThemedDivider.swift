//
//  ThemedDivider.swift
//  RecipeUI
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem

struct ThemedDivider: View {
    var height: CGFloat?

    var body: some View {
        if let height = height {
            Divider()
                .frame(height: height)
                .background(AppColors.divider)
        } else {
            Divider()
                .background(AppColors.divider)
        }
    }
}

#Preview {
    ThemedDivider(height: AppSpacing.small)
}
