//
//  ReceiveTransactionViewModel.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 05/09/25.
//

import SwiftUI
import Foundation
import BitcoinDevKit

final class ReceiveTransactionViewModel: ObservableObject {
    
    @Binding var path: NavigationPath
    private let bdkClient: BDKClient
    
    @Published var address: String?
    
    init(
        path: Binding<NavigationPath>,
        bdkClient: BDKClient = .live
    ) {
        _path = path
        self.bdkClient = bdkClient
    }
    
    func generateAddress() {
        do {
            let newAddress = try bdkClient.getAddress()
            self.address = newAddress
        } catch {
            print("Failed to generate address: \(error)")
        }
    }
    
    func copyAddress() {
        guard let address = address else { return }
        UIPasteboard.general.string = address
    }
}
