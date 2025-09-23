//
//  LanguageManager.swift
//  PadawanWallet
//
//  Created by Vinicius Silva Moreira on 23/09/25.
//

import SwiftUI
import Combine

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: PadawanLanguage = {
        if let saved = UserDefaults.standard.string(forKey: "appLanguage"),
           let lang = PadawanLanguage.allCases.first(where: { $0.rawValue == saved }) {
            return lang
        }
        return .english
    }() {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "appLanguage")
        }
    }
    
    private init() {}
    
    func localized(_ key: String) -> String {
        let bundle: Bundle
        if let path = Bundle.main.path(forResource: currentLanguage.code, ofType: "lproj"),
           let b = Bundle(path: path) {
            bundle = b
        } else {
            bundle = .main
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: "")
    }
}

extension String {
    var localized: String {
        return LanguageManager.shared.localized(self)
    }
}
