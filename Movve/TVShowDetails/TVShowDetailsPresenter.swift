//
//  TVShowDetailsPresenter.swift
//  Movve
//
//  Created by Victor Rubenko on 02.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class TVShowDetailsPresenter {

    // MARK: - Private properties -

    private unowned let view: TVShowDetailsViewInterface
    private let interactor: TVShowDetailsInteractorInterface
    private let wireframe: TVShowDetailsWireframeInterface
    
    private let mapper: MovieDBMapperInterface
    
    private let tvShowId: Int
    private var _tvShow: TVShowDetails?
    private var _cast: [CastMember] = []
    private var _sections: [TVShowDetailsSectionType] = []
    private var _videos: [Video] = []

    // MARK: - Lifecycle -

    init(
        view: TVShowDetailsViewInterface,
        interactor: TVShowDetailsInteractorInterface,
        wireframe: TVShowDetailsWireframeInterface,
        mapper: MovieDBMapperInterface,
        tvShowId: Int
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.mapper = mapper
        self.tvShowId = tvShowId
    }
}

// MARK: - Extensions -

extension TVShowDetailsPresenter: TVShowDetailsPresenterInterface {
    
    var tvShow: TVShowDetailsModel? {
        guard let tvShow = _tvShow else {
            return nil
        }
        return mapper.tvShowToTVShowDetailsModel(tvShow)
    }
    
    var cast: [CastMemberModel] {
        _cast.compactMap { mapper.castMemberToCastMemberModel($0) }
    }
    
    var sections: [TVShowDetailsSectionType] {
        _sections
    }
    
    var videos: [Video] {
        _videos
    }
    
    func loadData() {
        
        let group = DispatchGroup()
        
        group.enter()
        interactor.getTVShowDetails(id: tvShowId) { result in
            switch result {
            case .success(let tvShow):
                self._tvShow = tvShow
            case .failure(let error):
                self.wireframe.showAlertAndBack(with: "Error", message: error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        interactor.getCast(id: tvShowId) { result in
            switch result {
            case .success(let cast):
                self._cast = cast.cast
            case .failure(let error):
                self.wireframe.showAlertAndBack(with: "Error", message: error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        interactor.getTVShowVideos(id: tvShowId) { result in
            switch result {
            case .success(let videos):
                self._videos = videos.compactMap {
                    if $0.site.lowercased() == "youtube" && $0.name.lowercased().contains("trailer") {
                        return $0
                    }
                    return nil
                }
            case .failure(let error):
                self.wireframe.showAlertAndBack(with: "Error", message: error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            if self._tvShow != nil {
                self._sections.append(contentsOf: [.rating, .overview])
            }
            if !self._cast.isEmpty {
                self._sections.append(.cast)
            }
            if let homepage = self._tvShow?.homepage, let _ = URL(string: homepage) {
                self._sections.append(.watchNow)
            }
            if !self._videos.isEmpty {
                self._sections.append(.video)
            }
            self.view.reloadData()
        }
    }
    
    func selectWatchNow() {
        guard let homepage = _tvShow?.homepage, let url = URL(string: homepage) else {
            return
        }
        wireframe.openURL(url: url)
    }
}

