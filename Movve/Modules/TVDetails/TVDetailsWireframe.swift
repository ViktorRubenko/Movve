//
//  TVDetailsWireframe.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class TVDetailsWireframe: BaseWireframe<TVDetailsViewController> {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = TVDetailsViewController()
        super.init(viewController: moduleViewController)

        let interactor = TVDetailsInteractor()
        let presenter = TVDetailsPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension TVDetailsWireframe: TVDetailsWireframeInterface {
}
