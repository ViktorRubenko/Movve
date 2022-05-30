//
//  SceneDelegate.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import UIKit
import Kingfisher
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        
        let rootWireframe = RootWireframe(window: window)
        rootWireframe.setRootViewController()
        self.window = window
        
        window.overrideUserInterfaceStyle = .dark
    }
    
}

