/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

import SwiftUI

struct CoreView: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var walletPath: NavigationPath = .init()
    @State private var lessonPath: NavigationPath = .init()
    @State private var morePath: NavigationPath = .init()
    private let bdkClient: BDKClient
    
    init(
        bdkClient: BDKClient = .live
    ) {
        self.bdkClient = bdkClient
    }
    
    var body: some View {
        TabView {
            NavigationStack(path: $walletPath) {
                WalletView(
                    path: $walletPath,
                    bdkClient: bdkClient
                )
            }
            .tabItem {
                Label {
                    Text(languageManager.localizedString("bottom_nav_wallet"))
                } icon: {
                    Image(systemName: "bitcoinsign.square")
                }
            }

            NavigationStack(path: $lessonPath) {
                LessonsRootView()
            }
            .tabItem {
                Label {
                    Text(languageManager.localizedString("bottom_nav_chapters"))
                } icon: {
                    Image(systemName: "graduationcap")
                }
            }

            NavigationStack(path: $morePath) {
                MoreRootView(
                    path: $morePath,
                    bdkClient: bdkClient
                )
            }
            .tabItem {
                Label {
                    Text(languageManager.localizedString("bottom_nav_settings"))
                } icon: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .accentColor(colors.accent3)
        .onAppear {
            UITabBarAppearance.setupTabBarAppearance(colors: colors)
        }
    }
}

private extension UITabBarAppearance {
    static func setupTabBarAppearance(colors: PadawanColors) {
        let font = Fonts.uiKitFont(.medium, 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}
