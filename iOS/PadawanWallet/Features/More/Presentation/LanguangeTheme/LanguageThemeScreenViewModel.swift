//
//  LanguageThemeScreenViewModel.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 14/09/25.
//

import SwiftUI
import Foundation

@MainActor
final class LanguageThemeScreenViewModel: ObservableObject {
    
    @Published var fullScreenCover: MoreScreenNavigation?
    @Published var selectedLanguage: PadawanLanguage
    @Published var selectedTheme: PadawanColorTheme = Session.shared.themeChoice
    
    var disabledLanguages: [PadawanLanguage] = []
    var disabledThemes: [PadawanColorTheme] = [.vader]
    
    private let languageManager: LanguageManager
    
    init(languageManager: LanguageManager) {
        self.languageManager = languageManager
        self.selectedLanguage = languageManager.currentLanguage
    }
    
    func selectItem<T: LanguageThemeItemProtocol>(_ item: T) {
        switch item {
        case is PadawanLanguage:
            if let language = item as? PadawanLanguage, !disabledLanguages.contains(language) {
                selectedLanguage = language
                languageManager.setLanguage(language)
            }
            
        case is PadawanColorTheme:
            if let theme = item as? PadawanColorTheme, !disabledThemes.contains(theme) {
                selectedTheme = theme
                Session.shared.themeChoice = theme
            }
            
        default:
            break
        }
        
        fullScreenCover = .alert(
            data: .init(
                title: languageManager.localizedString("attention"),
                subtitle: languageManager.localizedString("alert_change_language"),
                primaryButtonTitle: languageManager.localizedString("button_yes"),
                secondaryButtonTitle: languageManager.localizedString("button_no"),
                onPrimaryButtonTap: { self.closeApp() }
            )
        )
    }
    
    func closeApp() {
        DispatchQueue.main.async {
            exit(0)
        }
    }
}
