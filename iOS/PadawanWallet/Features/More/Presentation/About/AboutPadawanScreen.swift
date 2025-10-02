/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

import SwiftUI

struct AboutPadawanScreen: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(languageManager.localizedString("about_text"))
                    .font(Fonts.font(.regular, 16))
                    .foregroundColor(colors.textLight)
                    .multilineTextAlignment(.leading)
                Text(languageManager.localizedString("privacy_text"))
                    .font(Fonts.font(.regular, 16))
                    .foregroundColor(colors.textLight)
                    .multilineTextAlignment(.leading)
                Button(action: {
                    if let url = URL(string: languageManager.localizedString("privacy_link")) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text(languageManager.localizedString("button_link_privacy"))
                        .font(Fonts.font(.regular, 16))
                        .foregroundColor(colors.accent2)
                        .underline()
                }
                
                Spacer()
            }
            .padding()
        }
        .background(colors.background)
        .navigationTitle(languageManager.localizedString("about_padawan"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
