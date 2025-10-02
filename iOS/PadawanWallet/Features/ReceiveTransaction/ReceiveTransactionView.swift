//
//  ReceiveTransactionView.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 05/09/25.
//

import BitcoinUI
import SwiftUI

private struct ViewAssets {
    static func navigationTitle(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString(Strings.receiveBitcoin)
    }
    
    static func buttonTitle(_ languageManager: LanguageManager) -> String {
        languageManager.localizedString(Strings.generateANewAddress)
    }
    
    static var copyIcon = Image(systemName: "document.on.document")
}

struct ReceiveTransactionView: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject private var viewModel: ReceiveTransactionViewModel
    
    init(
        path: Binding<NavigationPath>,
        bdkClient: BDKClient = .live
    ) {
        _viewModel = StateObject(wrappedValue: ReceiveTransactionViewModel(path: path, bdkClient: bdkClient))
    }
    
    var body: some View {
        BackgroundView {
            VStack(spacing: 12.0) {
                Spacer()
                buildQRCode()
                
                if let address = viewModel.address, !address.isEmpty {
                    Button {
                        viewModel.copyAddress()
                    } label: {
                        HStack(spacing: 12.0) {
                            
                            AddressFormattedView(
                                address: address,
                                columns: 4,
                                spacing: 2.0,
                                gridItemSize: 60
                            )
                            .font(Fonts.font(.regular, 18))

                            ViewAssets.copyIcon
                        }
                    }
                }
                
                Spacer()
                PadawanButton(title: ViewAssets.buttonTitle(languageManager)) {
                    viewModel.generateAddress()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .maxWidthScreen)
            .padding()
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(ViewAssets.navigationTitle(languageManager))
    }
    
    @ViewBuilder
    private func buildQRCode() -> some View {
        if let address = viewModel.address, !address.isEmpty {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(colors.background2)
                Button {
                    viewModel.copyAddress()
                } label: {
                    QRCodeView(qrCodeType: .bitcoin(address))
                        .padding()
                }
            }
            .frame(width: 320, height: 320)
        } else {
            EmptyView()
        }
    }
}
