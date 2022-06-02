//
//  DetailsViewController.swift
//  Movve
//
//  Created by Victor Rubenko on 02.06.2022.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    let posterInfoView = PosterInfoView(frame: .zero, bottomGradientColor: .appBackground)
    var posterHeight: Constraint!
    var prevNavBarAppearance: UINavigationBarAppearance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevNavBarAppearance = navigationController?.navigationBar.standardAppearance
        updateNavBarTransparency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
        if let prevNavBarAppearance = prevNavBarAppearance {
            navigationController?.navigationBar.standardAppearance = prevNavBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = prevNavBarAppearance
        }
    }
    
    func updateNavBarTransparency(offset yOffset: CGFloat = -1000) {
        var offset = (yOffset + 200) / 50
        offset = offset > 1 ? 1 : offset
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .appBackground.withAlphaComponent(offset - 0.03)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.appTextColor.withAlphaComponent(offset)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
            posterHeight.deactivate()
            posterInfoView.snp.makeConstraints { make in
                posterHeight = make.height.equalTo(offset <= 0 ? offset * -1 : 0).constraint
            }
            updateNavBarTransparency(offset: offset)
    }
}
