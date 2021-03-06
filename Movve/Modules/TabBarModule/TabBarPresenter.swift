//
//  TabBarPresenter.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class TabBarPresenter {

    // MARK: - Private properties -

    private unowned let view: TabBarViewInterface
    private let wireframe: TabBarWireframeInterface

    // MARK: - Lifecycle -

    init(
        view: TabBarViewInterface,
        wireframe: TabBarWireframeInterface
    ) {
        self.view = view
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension TabBarPresenter: TabBarPresenterInterface {
}
