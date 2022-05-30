//
//  RootWireframe.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import UIKit

final class RootWireframe {
    var window: UIWindow!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setRootViewController() {
        let initialViewController = TabBarWireframe().viewController
        initialViewController.setWireframes([HomeWireframe(), FavoritesWireframe()])
        window.rootViewController = initialViewController
    }
}
