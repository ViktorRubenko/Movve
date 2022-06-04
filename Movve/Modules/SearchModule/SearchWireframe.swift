//
//  SearchWireframe.swift
//  Movve
//
//  Created by Victor Rubenko on 04.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class SearchWireframe: BaseWireframe<SearchViewController> {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = SearchViewController()
        super.init(viewController: moduleViewController)

        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension SearchWireframe: SearchWireframeInterface {
    func navigateToMovieDetails(movieId: Int) {
        navigationController?.pushWireframe(MovieDetailsWireframe(movieId: movieId), animated: true)
    }
    
    func navigateToTVShowDetails(tvShowId: Int) {
        navigationController?.pushWireframe(TVShowDetailsWireframe(tvShowId: tvShowId), animated: true)
    }
}
