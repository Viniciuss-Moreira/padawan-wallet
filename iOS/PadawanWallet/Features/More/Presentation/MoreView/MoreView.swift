/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

import SwiftUI

private struct MoreRootViewAssets {
    static func title(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("settings")
    }
    
    static func subtitle(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("everything_else")
    }
    
    static func buttonRecoverPhase(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("recovery_phrase")
    }
    
    static func buttonSendCoinBack(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("send_signet_coins_back")
    }
    
    static func buttonSelectLanguage(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("change_language")
    }
    
    static func buttonAboutPadawan(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("about_padawan")
    }
    
    static func buttonReset(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString("reset_completed_chapters")
    }
    
    static func separatorWithVersion(_ languageManager: LanguageManager, _ version: String) -> String {
        "\(languageManager.localizedString("padawan_wallet")) \(version)"
    }
    
    static var chevronRight = Image(systemName: "chevron.right.2")
}

struct MoreRootView: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject private var viewModel: MoreViewModel
    
    init(
        path: Binding<NavigationPath>,
        bdkClient: BDKClient = .live
    ) {
        _viewModel = StateObject(wrappedValue: MoreViewModel(path: path, bdkClient: bdkClient))
    }
    
    var body: some View {
        BackgroundView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12.0) {
                    Group {
                        Text(MoreRootViewAssets.title(languageManager))
                            .font(Fonts.title)
                        Text(MoreRootViewAssets.subtitle(languageManager))
                            .font(Fonts.subtitle)
                    }
                    .foregroundStyle(colors.text)
                    
                    buildButtons()
                    
                    buildSeparator()
                    
                    FilledButton(
                        title: MoreRootViewAssets.buttonReset(languageManager),
                        titleColor: colors.text,
                        backgroundColor: colors.errorRed
                    ) {
                        viewModel.resetWallet()
                    }
                    .padding(.top, 12)
                    
                    Spacer()
                }
                .frame(maxWidth: .maxWidthScreen)
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func buildButtons() -> some View {
        VStack(spacing: 20) {
            FilledButton(
                title: MoreRootViewAssets.buttonRecoverPhase(languageManager),
                icon: MoreRootViewAssets.chevronRight
            ) {
                viewModel.showRecoveryPhrase()
            }
            
            FilledButton(
                title: MoreRootViewAssets.buttonSendCoinBack(languageManager),
                icon: MoreRootViewAssets.chevronRight
            ) {
                viewModel.showSendCoinsBack()
            }
            
            FilledButton(
                title: MoreRootViewAssets.buttonSelectLanguage(languageManager),
                icon: MoreRootViewAssets.chevronRight
            ) {
                viewModel.showLanguage()
            }
            
            FilledButton(
                title: MoreRootViewAssets.buttonAboutPadawan(languageManager),
                icon: MoreRootViewAssets.chevronRight
            ) {
                viewModel.showAbout()
            }
        }
        .padding(.top)
        .navigationDestination(for: MoreScreenNavigation.self) { item in
            Group {
                switch item {
                case .recoveryPhase(let words):
                    RecoveryPhraseScreen(words: words)
                    
                case .sendCoinsBack:
                    SendCoinsBackScreen()
                    
                case .language:
                    LanguageThemeScreen()
                    
                case .about:
                    AboutPadawanScreen()
                
                case .alert(let data):
                    AlertModalView(data: data)
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    @ViewBuilder
    private func buildSeparator() -> some View {
        VStack(spacing: 4) {
            Divider()
                .background(colors.textFaded)
            Text(MoreRootViewAssets.separatorWithVersion(languageManager, viewModel.version))
                .font(.footnote)
                .foregroundColor(colors.textLight)
            Divider()
                .background(colors.textFaded)
        }
        .padding(.top, 16)
    }
}

#if DEBUG
#Preview {
    MoreRootView(path: .constant(.init()))
        .environment(\.padawanColors, .tatooineDesert)
        .environmentObject(LanguageManager.shared)
}
#endif
