//
//  ImportWalletView.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 28/07/25.
//

import SwiftUI

private extension ImportWalletView {
    struct ImportWalletViewStrings {
        static func screenTitle(_ languageManager: LanguageManager) -> String {
            languageManager.localizedString("recover_a_wallet")
        }
        static func subtitle(_ languageManager: LanguageManager) -> String {
            languageManager.localizedString("enter_your_12_words")
        }
        static func buttonTitle(_ languageManager: LanguageManager) -> String {
            languageManager.localizedString("recover_wallet")
        }
        static func wordNumber(_ number: Int, _ languageManager: LanguageManager) -> String {
            languageManager.localizedString("word_number_\(number)")
        }
    }
}

struct ImportWalletView: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager

    @StateObject private var viewModel: ImporViewModel
    
    init(
        path: Binding<NavigationPath>,
        bdkClient: BDKClient = .live
    ) {
        _viewModel = StateObject(wrappedValue: ImporViewModel(path: path, bdkClient: bdkClient))
    }
    
    var body: some View {
        BackgroundView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(ImportWalletViewStrings.screenTitle(languageManager))
                        .font(Fonts.title)
                        .foregroundStyle(colors.textFaded)
                        .multilineTextAlignment(.leading)
                    
                    Text(ImportWalletViewStrings.subtitle(languageManager))
                        .font(Fonts.subtitle)
                        .foregroundStyle(colors.textFaded)
                        .multilineTextAlignment(.leading)
                    
                    buildForm()
                    
                    Spacer().frame(height: 20)
                    
                    PadawanButton(title: ImportWalletViewStrings.buttonTitle(languageManager)) {
                        dismissKeyBoard()
                        viewModel.importWallet()
                    }
                }
                .frame(maxWidth: .maxWidthScreen, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
            }
        }
        .fullScreenCover(item: $viewModel.fullScreenCover) { item in
            switch item {
            case .alertError(let data):
                AlertModalView(data: data)
                    .background(BackgroundClearView())
            default:
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    private func buildForm() -> some View {
        ForEach(0..<12) { i in
            buildTextField(
                label: ImportWalletViewStrings.wordNumber(i+1, languageManager),
                placeholder: ImportWalletViewStrings.wordNumber(i+1, languageManager),
                text: .init(get: {
                    viewModel.words[i]
                }, set: { value in
                    viewModel.words[i] = value
                })
            )
        }
    }
    
    @ViewBuilder
    private func buildTextField(
        label: String,
        placeholder: String,
        text: Binding<String>
    ) -> some View {
        InputTextView(
            text: text,
            label: label,
            placeholder: placeholder,
            autocorrectionDisabled: true,
            autocapitalization: .never
        )
    }
}

#if DEBUG
#Preview {
    ImportWalletView(
        path: .constant(.init()),
        bdkClient: .mock
    )
    .environment(\.padawanColors, .tatooineDesert)
    .environmentObject(LanguageManager.shared)
}
#endif
