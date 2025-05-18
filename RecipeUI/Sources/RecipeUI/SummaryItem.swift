//
//  SummaryItem.swift
//  RecipeUI
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import DesignSystem
import RecipeKit

public struct SummaryItem {
    public let title: String
    public let value: String
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

public struct SummaryRowView: View {
    public let items: [SummaryItem]

    public init(items: [SummaryItem]) {
        self.items = items
    }

    public var body: some View {
        VStack(spacing: AppSpacing.zero) {
            ThemedDivider()

            HStack {
                ForEach(items.indices, id: \.self) { index in
                    summaryColumn(title: items[index].title, value: items[index].value)
                    if index < items.count - 1 {
                        ThemedDivider(height: AppSpacing.extraLarge)
                    }
                }
            }
            .padding(.vertical, AppSpacing.regular)
            .padding(.horizontal)

            ThemedDivider()
        }
    }

    @ViewBuilder
    private func summaryColumn(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(AppTypography.caption)
                .foregroundColor(AppColors.secondaryText)

            Text(value)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SummaryRowView(items: [
        .init(title: "Serves", value: "4"),
        .init(title: "Prep", value: "15 mins"),
        .init(title: "Cook", value: "20 mins")
    ])
}
