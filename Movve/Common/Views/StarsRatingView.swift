//
//  RatingView.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class StarsRating: UIView {
    var rating: Double = 0.0 {
        didSet {
            let intRating = Int(round(rating))
            for i in 0..<5 {
                imageViews[i].tintColor = i < intRating ? frontColor : backColor
            }
        }
    }
    private let frontColor: UIColor
    private let backColor: UIColor
    
    private let imageViews: [UIImageView]
    
    init(frontColor: UIColor, backColor: UIColor) {
        self.frontColor = frontColor
        self.backColor = backColor
        
        imageViews = (0..<5).map { _ in
            UIImageView(image: UIImage(named: "Star"))
        }
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackView = UIStackView()
        
        for view in imageViews {
            stackView.addArrangedSubview(view)
        }
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}

