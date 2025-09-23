//
//  LanguageThemeScreen.swift
//  PadawanWallet
//
//  Created by Rubens Machion on 21/09/25.
//

import SwiftUI

struct LanguageThemeScreen: View {
    @Environment(\.padawanColors) private var colors
    @StateObject private var viewModel: LanguageThemeScreenViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: LanguageThemeScreenViewModel())
    }
    
    var body: some View {
        BackgroundView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12.0) {
                    Text(Strings.selectLanguage)
                        .font(Fonts.subtitle)
                    
                    buildSection(
                        title: Strings.appLevelLanguage,
                        type: PadawanLanguage.self,
                        itemSelected: viewModel.selectedLanguage,
                        disableItems: viewModel.disabledLanguages
                    )
                    
                    Spacer().frame(height: 18)
                    
                    buildSection(
                        title: Strings.colorTheme,
                        type: PadawanColorTheme.self,
                        itemSelected: viewModel.selectedTheme,
                        disableItems: viewModel.disabledThemes
                    )
                    
                    Spacer()
                }
                .frame(maxWidth: .maxWidthScreen)
                .padding()
            }
        }
        .fullScreenCover(item: $viewModel.fullScreenCover, content: { item in
            switch item {
            case MoreScreenNavigation.alert(let data):
                AlertModalView(data: data)
                
            default:
                EmptyView()
            }
        })
        .navigationTitle(Strings.changeLanguage)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func buildSection<T: LanguageThemeItemProtocol>(
        title: String,
        type: T.Type,
        itemSelected: T,
        disableItems: [T]
    ) -> some View {
        VStack(alignment: .leading) {
            buildSectionTitle(title)
            Spacer().frame(height: 10)
            
            buildItems(
                type,
                itemSelected: itemSelected,
                disableItems: disableItems
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func buildSectionTitle(_ title: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(Strings.appLevelLanguage)
                .font(Fonts.font(.semibold, 20))
                .foregroundStyle(colors.text)
            
            Rectangle()
                .frame(height: 1)
                .background(colors.text)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func buildItems<T: LanguageThemeItemProtocol>(
        _ type: T.Type,
        itemSelected: T,
        disableItems: [T]
    ) -> some View {
        ForEach(Array(T.allCases)) { item in
            Button {
                viewModel.selectItem(item)
            } label: {
                let isSelectedItem = itemSelected.rawValue == item.rawValue
                HStack(spacing: 12) {
                    RadioBoxView(isSelected: .constant(isSelectedItem))
                        .allowsHitTesting(false)
                    Text(item.rawValue)
                        .font(Fonts.font(.regular, 18))
                        .foregroundStyle(.black)
                }
                .padding(.leading, 8)
                .padding(.vertical, 6)
                .opacity(disableItems.contains(item) ? 0.2 : 1.0)
            }
        }
    }
}
