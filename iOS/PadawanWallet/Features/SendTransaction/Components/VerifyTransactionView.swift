//
//  VerifyTransactionView.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 05/09/25.
//

import SwiftUI

struct VerifyTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    
    private let amount: String
    private let address: String
    private let tax: String
    private let primaryAction: () -> Void
    
    init(amount: String, address: String, tax: String, primaryAction: @escaping () -> Void) {
        self.amount = amount
        self.address = address
        self.tax = tax
        self.primaryAction = primaryAction
    }
    
    var body: some View {
        BackgroundView {
            VStack(spacing: 20) {
                Text(languageManager.localizedString(Strings.confirmTransaction))
                    .font(Fonts.font(.medium, 24))
                    .foregroundStyle(colors.text)
                    .padding(.top, 24)
                
                VStack(alignment: .leading, spacing: 16) {
                    buildTitle(
                        languageManager.localizedString(Strings.amount),
                        subtitle: amount
                    )
                    
                    buildTitle(
                        languageManager.localizedString(Strings.address),
                        subtitle: address
                    )
                    
                    buildTitle(
                        languageManager.localizedString(Strings.totalFee),
                        subtitle: tax
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                PadawanButton(title: languageManager.localizedString(Strings.confirmAndBroadcast)) {
                    dismiss()
                    primaryAction()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
        }
        .presentationDragIndicator(.visible)
        .presentationDetents([.height(400.0)])
    }
    
    @ViewBuilder
    private func buildTitle(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Fonts.font(.medium, 20))
            Text(subtitle)
                .font(Fonts.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(colors.text)
    }
}

#if DEBUG
#Preview {
    VerifyTransactionView(
        amount: "200000 sats",
        address: "tb1pd8jmenqpe7rz2mavfdx7uc8pj7vskxv4rl6avxlqsw2u8u7d4gfs97durt",
        tax: "400 sats",
        primaryAction: { })
}
#endif
