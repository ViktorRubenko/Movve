//
//  ValueStarsRatingView.swift
//  Movve
//
//  Created by Victor Rubenko on 03.06.2022.
//

import UIKit

class ValueStarsRatingView: UIView {

    private let starsView = StarsRatingView(frontColor: .ratingFrontColor, backColor: .appSecondaryTextColor)
    private let ratingLabel = UILabel()
    private var didSetupConstraints = false
    var font: UIFont {
        didSet {
            ratingLabel.font = font
        }
    }

    init(font: UIFont = .systemFont(ofSize: 20, weight: .semibold)) {
        self.font = font
        
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints.toggle()
            
            ratingLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            starsView.snp.makeConstraints { make in
                make.centerY.equalTo(ratingLabel)
                make.height.equalTo(ratingLabel)
                make.leading.equalTo(ratingLabel.snp.trailing).offset(4).priority(.high)
                make.trailing.equalToSuperview()
            }
        }
        
        super.updateConstraints()
    }
    
    func setRating(rating: Double, maxValue: Double = 5.0) {
        setupRatingLabel(rating, font: font)
        starsView.rating = rating * 5.0 / maxValue
    }
}

private extension ValueStarsRatingView {
    func setupViews() {
        addSubview(ratingLabel)
        addSubview(starsView)
    }
    
    func setupRatingLabel(_ rating: Double, font: UIFont) {
        ratingLabel.text = String(rating)
        ratingLabel.font = font
        ratingLabel.textColor = .ratingFrontColor
    }
}
