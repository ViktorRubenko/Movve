//
//  TabBarViewController.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Public properties -
    
    var presenter: TabBarPresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(
            roundedRect:
                CGRect(
                    x: 30,
                    y: self.tabBar.bounds.minY - 5,
                    width: self.tabBar.bounds.width - 60,
                    height: self.tabBar.bounds.height + 10
                ),
            cornerRadius: (self.tabBar.frame.width / 2)
        ).cgPath
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.fillColor = UIColor.appTabBar.cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        if let items = self.tabBar.items {
            items.forEach {
                $0.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)
            }
        }
        self.tabBar.itemWidth = 30.0
        self.tabBar.itemPositioning = .fill
    }
    
}

// MARK: - Extensions -

extension TabBarViewController: TabBarViewInterface {
}
