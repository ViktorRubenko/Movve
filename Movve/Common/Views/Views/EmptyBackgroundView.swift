//
//  EmptyBackgroundView.swift
//  Movve
//
//  Created by Victor Rubenko on 03.06.2022.
//

import UIKit

class EmptyBackgroundView: UIView {
    
    private let imageView = UIImageView()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private var didSetupConstraints = false

    init(image: UIImage?, topText: String?, bottomText: String?) {
        super.init(frame: .zero)
        setupViews()
        setupImageView(image: image)
        setupLabels(topText: topText, bottomText: bottomText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints.toggle()
            
            topLabel.snp.makeConstraints { make in
                make.top.equalTo(self.snp.centerY)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            bottomLabel.snp.makeConstraints { make in
                make.top.equalTo(topLabel.snp.bottom)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            imageView.snp.makeConstraints { make in
                make.bottom.equalTo(topLabel.snp.top)
                make.width.equalToSuperview().multipliedBy(0.33)
                make.height.equalTo(imageView.snp.width)
                make.centerX.equalToSuperview()
            }
        }
        super.updateConstraints()
    }

}

private extension EmptyBackgroundView {
    func setupLabels(topText: String?, bottomText: String?) {
        topLabel.text = topText
        topLabel.textColor = .appSecondaryTextColor
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        topLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        
        bottomLabel.text = bottomText
        bottomLabel.textColor = .appSecondaryTextColor
        bottomLabel.textAlignment = .center
        bottomLabel.numberOfLines = 0
        bottomLabel.font = .systemFont(ofSize: 20)
        
    }
    
    func setupImageView(image: UIImage?) {
        imageView.image = image
        imageView.tintColor = .appSecondaryTextColor
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupViews() {
        addSubview(topLabel)
        addSubview(imageView)
        addSubview(bottomLabel)
    }
}
