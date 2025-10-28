//
//  ImportWalletView.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 28/07/25.
//

import SwiftUI

private extension ImportWalletView {
    struct ImportWalletViewStrings {
        static var screenTitle: String { LanguageManager.shared.localizedString(forKey: "recover_a_wallet") }
            static var subtitle: String { LanguageManager.shared.localizedString(forKey: "enter_your_12_words") }
        
            static var buttonTitle: String { LanguageManager.shared.localizedString(forKey: "recover_wallet") }
        
        static func wordNumber(_ number: Int) -> String {
            "Word \(number)"
        }
    }
}

struct ImportWalletView: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject private var languageManager: LanguageManager
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
                    Text(ImportWalletViewStrings.screenTitle)
                        .font(Fonts.title)
                        .foregroundStyle(colors.textFaded)
                        .multilineTextAlignment(.leading)
                    
                    Text(ImportWalletViewStrings.subtitle)
                        .font(Fonts.subtitle)
                        .foregroundStyle(colors.textFaded)
                        .multilineTextAlignment(.leading)
                    
                    buildForm()
                    
                    Spacer().frame(height: 20)
                    
                    PadawanButton(title: ImportWalletViewStrings.buttonTitle) {
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
                label: ImportWalletViewStrings.wordNumber(i+1),
                placeholder: ImportWalletViewStrings.wordNumber(i+1),
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
