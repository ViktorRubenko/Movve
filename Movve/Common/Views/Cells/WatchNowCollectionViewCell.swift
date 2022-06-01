//
//  WatchNowCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 01.06.2022.
//

import UIKit

class WatchNowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WatchNowCollectionViewCell"
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.appTextColor, for: .normal)
        button.addTarget(self, action: #selector(didTapWatchNowButton), for: .touchUpInside)
        if #available(iOS 15, *) {
            
            var attText = AttributedString("Watch Now")
            attText.font = .systemFont(ofSize: 25)
            
            var config = UIButton.Configuration.filled()
            config.attributedTitle = attText
            config.titlePadding = 10
            config.baseBackgroundColor = .buttonColor
            config.cornerStyle = .medium
            button.configuration = config
        } else {
            button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            button.setTitle("Watch Now", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 25)
            button.backgroundColor = .buttonColor
            button.layer.cornerRadius = 10
        }
        return button
    }()
    
    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44).priority(.high)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func didTapWatchNowButton() {
        buttonAction?()
    }
}
