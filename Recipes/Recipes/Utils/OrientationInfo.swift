//
//  OrientationInfo.swift
//  Recipes
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import Combine

class OrientationInfo: ObservableObject {
    @Published var isPortrait: Bool
    private var cancellable: AnyCancellable?

    init() {
        // Set initial orientation using interfaceOrientation from windowScene
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first {
            self.isPortrait = windowScene.interfaceOrientation.isPortrait
        } else {
            self.isPortrait = true
        }

        // Observe orientation change notifications
        cancellable = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { _ in
                let orientation = UIDevice.current.orientation
                return orientation.isValidInterfaceOrientation ? orientation.isPortrait : nil
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isPortrait, on: self)
    }
}

extension OrientationInfo {
    // Helper for setting preview orientation
    static func preview(isPortrait: Bool) -> OrientationInfo {
        let mock = OrientationInfo()
        mock.isPortrait = isPortrait
        return mock
    }
}

