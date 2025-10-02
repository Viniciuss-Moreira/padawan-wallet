/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

import SwiftUI
import BitcoinUI

struct SendCoinsBackScreen: View {
    @State private var copiedAddress = false
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        BackgroundView {
            ScrollView {
                VStack(spacing: 20) {
                    buildQRCode()
                    
                    buildCopyButton()
                    
                    Text(languageManager.localizedString("sendCoinsBack_text"))
                        .font(Fonts.font(.regular, 16))
                        .foregroundStyle(colors.text)
                        .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle(languageManager.localizedString("sendCoinsBack_title"))
    }
    
    @ViewBuilder
    private func buildCopyButton() -> some View {
        Button {
            copyAddress()
        } label: {
            HStack(spacing: 12.0) {
                AddressFormattedView(
                    address: languageManager.localizedString("sendCoinsBack_address"),
                    columns: 4,
                    spacing: 2.0,
                    gridItemSize: 60
                )
                .font(Fonts.font(.regular, 18))

                if copiedAddress {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "document.on.document")
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildQRCode() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(colors.background2)
            Button {
                copyAddress()
            } label: {
                QRCodeView(qrCodeType: .bitcoin(languageManager.localizedString("sendCoinsBack_address")))
                    .padding()
            }
        }
        .frame(width: 320, height: 320)
    }
    
    private func copyAddress() {
        UIPasteboard.general.string = languageManager.localizedString("sendCoinsBack_address")
        copiedAddress = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            copiedAddress = false
        }
    }
}
