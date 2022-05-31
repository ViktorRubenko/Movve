//
//  PosterInfoView.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class PosterInfoView: UIView {
    
    private var posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .appTextColor
        return label
    }()
    
    private let gradientView: GradientView
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .appSecondaryTextColor
        label.textAlignment = .center
        return label
    }()
    
    init(frame: CGRect, bottomGradientColor: UIColor) {
        gradientView = GradientView(
            gradientStartColor: bottomGradientColor,
            gradientEndColor: .clear,
            gradientStartPoint: CGPoint(x: 0.5, y: 1),
            gradientEndPoint: CGPoint(x: 0.5, y: 0)
        )
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods -

extension PosterInfoView {
    
    private func setupViews() {
        addSubview(posterImageView)
        addSubview(gradientView)
        addSubview(titleLabel)
        addSubview(infoLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalTo(posterImageView)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel.snp.top).offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func configure(
        posterURL: URL?,
        title: String,
        releaseYear: String,
        genres: String,
        duration: String
    ) {
        
        titleLabel.text = title
        infoLabel.text = "\(releaseYear) • \(genres) • \(duration)"
        
        guard let posterURL = posterURL else {
            return
        }
        posterImageView.kf.setImage(
            with: posterURL,
            placeholder: UIImage(systemName: "film"),
            options: nil,
            completionHandler: nil)
    }
}
