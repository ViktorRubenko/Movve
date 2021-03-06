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
    
    lazy var returnNavButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(.returnNavBarIcon, for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        let buttonItem = UIBarButtonItem(customView: button)
        let currWidth = buttonItem.customView?.widthAnchor.constraint(equalToConstant: 28)
        let currHeight = buttonItem.customView?.heightAnchor.constraint(equalToConstant: 28)
        currWidth?.isActive = true
        currHeight?.isActive = true
        return buttonItem
    }()
    
    lazy var addToFavoritesNavButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(.addToFavoriteIcon, for: .normal)
        button.addTarget(self, action: #selector(didTapFavoritesButtonAction), for: .touchUpInside)
        
        let buttonItem = UIBarButtonItem(customView: button)
        let currWidth = buttonItem.customView?.widthAnchor.constraint(equalToConstant: 28)
        let currHeight = buttonItem.customView?.heightAnchor.constraint(equalToConstant: 28)
        currWidth?.isActive = true
        currHeight?.isActive = true
        return buttonItem
    }()
    
    lazy var removeFromFavoritesNavButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(.removeFromFavoriteIcon, for: .normal)
        button.addTarget(self, action: #selector(didTapFavoritesButtonAction), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        
        let buttonItem = UIBarButtonItem(customView: button)
        let currWidth = buttonItem.customView?.widthAnchor.constraint(equalToConstant: 28)
        let currHeight = buttonItem.customView?.heightAnchor.constraint(equalToConstant: 28)
        currWidth?.isActive = true
        currHeight?.isActive = true
        return buttonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBarTransparency()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
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
    
    func setupNavigationBar(isInFavorite: Bool = false) {
        navigationItem.leftBarButtonItem = returnNavButton
        navigationItem.rightBarButtonItem = isInFavorite ? removeFromFavoritesNavButton : addToFavoritesNavButton
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapFavoritesButtonAction() {
        didTapFavoritesButton()
    }
    
    func didTapFavoritesButton() {
        print("did tap favorites button")
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
//
