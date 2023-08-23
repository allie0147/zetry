//
//  SearchCoordinator.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/23.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct SearchCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<SearchScreen.State>]

        public init(routes: [Route<SearchScreen.State>] = [.root(.search(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }

    public enum Action: IndexedRouterAction {
        case updateRoutes([Route<SearchScreen.State>])
        case routeAction(Int, action: SearchScreen.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
