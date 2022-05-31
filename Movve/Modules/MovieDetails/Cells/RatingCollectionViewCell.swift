//
//  RatingCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RatingCollectionViewCell"
    
    var rating: Double = 0.0 {
        didSet {
            starsRating.rating = rating / 2
            ratingLabel.text = "\(rating)"
        }
    }
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .ratingFrontColor
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let starsRating = StarsRatingView(frontColor: .ratingFrontColor, backColor: .appSecondaryTextColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let container = UIView()
        container.addSubview(ratingLabel)
        container.addSubview(starsRating)
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        starsRating.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.height.equalTo(ratingLabel)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
