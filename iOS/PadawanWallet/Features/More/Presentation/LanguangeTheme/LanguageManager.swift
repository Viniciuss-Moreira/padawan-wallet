//
//  LanguageManager.swift
//  PadawanWallet
//
//  Created by Vinicius Silva Moreira on 01/10/25.
//

import SwiftUI
import Combine

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: PadawanLanguage = Session.shared.languageChoice
    
    private init() { }
    
    func displayName(for language: PadawanLanguage) -> String {
        switch language {
        case .english: return localizedString("english")
        case .spanish: return localizedString("spanish")
        case .portuguese: return localizedString("portuguese")
        case .french: return localizedString("french")
        }
    }

    
    func setLanguage(_ language: PadawanLanguage) {
        currentLanguage = language
        Session.shared.languageChoice = language
        UserDefaults.standard.set(language.code, forKey: "appLanguage")
    }
    
    func localizedString(_ key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage.code, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return key
        }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

