//
//  PosterInfoCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class PosterInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterInfoCollectionViewCell"
    
    private var posterInfoView = PosterInfoView(frame: .zero, bottomGradientColor: .appBackground)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PosterInfoCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(posterInfoView)
        
        posterInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(_ model: MovieDetailsModel) {
        posterInfoView.configure(
            posterURL: model.posterURL,
            title: model.title,
            releaseYear: model.releaseYear,
            genres: model.genres,
            duration: model.duration
        )
    }
}
