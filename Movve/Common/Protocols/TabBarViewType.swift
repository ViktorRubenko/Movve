//
//  TabBarViewType.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import UIKit

protocol TabBarViewType {
    
    var tabIcon: UIImage { get }
    var tabTitle: String? { get }
    
    var tabView: UIViewController { get }
    
}

