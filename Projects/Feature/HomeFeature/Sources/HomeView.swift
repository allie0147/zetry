//
//  HomeView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct HomeView: View {
    public let store: StoreOf<HomeStore>
    private let livingColumns: [GridItem] = [.init(.flexible(), spacing: 12), .init(.flexible(), spacing: 12)]
    private let categoryColumns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .top), count: 5)

    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                // TODO: -로고 반영
                Text("zetry")
                    .fontStyle(
                        .subtitle1,
                        foregroundColor: .primary(.primary)
                    )
                    .padding(.leading, 17)
                    .padding(.bottom, 12)

                searchNavigationView()
                    .onTapGesture {
                        viewStore.send(.routeToSearch)
                    }

                ScrollView {
                    categorySectionView(viewStore: viewStore)
                    divider
                    livingSectionView(viewStore: viewStore)
                }
            }
            .onAppear {
                viewStore.send(.animatingList)
            }
        }
    }

    var divider: some View {
        Color
            .zetry(.grayScale(.gray0))
            .frame(height: 7)
    }

    @ViewBuilder
    private func categorySectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        LazyVGrid(columns: categoryColumns) {
            ForEach(viewStore.categories.indices, id: \.self) { index in
                CategoryItemCell(
                    viewStore.categories[index].rawValue,
                    size: 54,
                    imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                )
                .animatedList(viewStore.isAnimated, index: index)
            }
        }
        .padding(.top, 26)
    }

    @ViewBuilder
    private func livingSectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("생활정보")
                .fontStyle(.subtitle3)

            LazyVGrid(
                columns: livingColumns,
                spacing: 28
            ) {
                ForEach(0 ... 9, id: \.self) { index in
                    LivingItemCell(
                        "쓰레기 잘 버리는 법",
                        imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                    )
                    .animatedList(viewStore.isAnimated, index: index)
                    .onTapGesture {
                        viewStore.send(.routeToLiving)
                    }
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private func searchNavigationView() -> some View {
        HStack(spacing: 0) {
            ZetryIcon(
                DesignSystemAsset.Icons.magnifyingglass,
                foregroundColor: .grayScale(.gray8),
                size: .larger
            )
            .padding(.leading, 8)
            .padding(.trailing, 4)

            Color
                .zetry(.grayScale(.gray2))
                .padding(.vertical, 11)
                .frame(width: 1, height: 40)

            Text("분리수거 방법이 궁금한 쓰레기를 검색해보세요")
                .fontStyle(.body2, foregroundColor: .grayScale(.gray7))
                .padding(.leading, 8)

            Spacer()
        }
        .frame(height: 46)
        .background {
            Color.zetry(.primary(.primary0))
        }
        .cornerRadius(10)
        .padding(.horizontal, 15)
    }
}
