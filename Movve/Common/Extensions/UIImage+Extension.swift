//
//  UIImage+Extension.swift
//  Movve
//
//  Created by Victor Rubenko on 01.06.2022.
//

import UIKit

extension UIImage {
    static var posterPlaceholder: UIImage? {
        UIImage(named: "poster_placeholder")
    }
    static var personPlaceholder: UIImage? {
        UIImage(named: "human_placholder")
    }
    static var addToFavoriteIcon: UIImage? {
        UIImage(named: "bookmark")
    }
    static var removeFromFavoriteIcon: UIImage? {
        UIImage(named: "filled_bookmark")
    }
    static var returnNavBarIcon: UIImage? {
        UIImage(named: "chevron_left_fill")
    }
    static var searchIcon: UIImage? {
        UIImage(systemName: "magnifyingglass.circle")
    }
    static var logo: UIImage? {
        UIImage(named: "logo")
    }
}
