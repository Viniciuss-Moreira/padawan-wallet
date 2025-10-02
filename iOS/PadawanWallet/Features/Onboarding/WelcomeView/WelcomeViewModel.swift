//
//  WelcomeViewModel.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 28/07/25.
//

import SwiftUI

final class WelcomeViewModel: ObservableObject {
    
    struct OnboardingPage: Identifiable {
        let id = UUID()
        let image: Image
        let titleKey: String
        let textKey: String
    }
    
    @Binding var path: NavigationPath
    @Published var sheetScreen: WelcomeScreenNavigation?
    @Published var fullScreenCover: ImportWalletNavigation?
    @Published var onboardingPages: [OnboardingPage] = []
    
    private let bdkClient: BDKClient
    
    var createWalletButtonTitleKey: String { "welcome_create_wallet" }
    var importWalletButtonTitleKey: String { "welcome_import_wallet" }
    
    init(path: Binding<NavigationPath>, bdkClient: BDKClient) {
        _path = path
        self.bdkClient = bdkClient
        self.onboardingPages = Self.makeOnboardingPages()
    }
    
    private static func makeOnboardingPages() -> [OnboardingPage] {
        [
            OnboardingPage(
                image: Asset.Images.padawantransparent.toImage,
                titleKey: "onboard_title_1",
                textKey: "onboard_text_1"
            ),
            OnboardingPage(
                image: Asset.Images.bitcoinicon1.toImage,
                titleKey: "onboard_title_2",
                textKey: "onboard_text_2"
            ),
            OnboardingPage(
                image: Image(systemName: "graduationcap"),
                titleKey: "onboard_title_3",
                textKey: "onboard_text_3"
            )
        ]
    }
    
    // MARK: - Navigation
    func createWallet() {
        do {
            try bdkClient.createNewWallet()
            Session.shared.setNeedOnboarding(false)
        } catch let error as BDKServiceError {
            fullScreenCover = .alertError(data: .init(error: error))
        } catch {
            fullScreenCover = .alertError(data: .init(error: .generic))
        }
    }
    
    func importWallet() {
        if isIpad {
            sheetScreen = .importWallet
        } else {
            path.append(WelcomeScreenNavigation.importWallet)
        }
    }
}
