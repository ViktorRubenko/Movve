//
//  CastMemberCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class CastMemberCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CastMemberCollectionViewCell"
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appTextColor
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    private var characterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appSecondaryTextColor
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        characterLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
}

extension CastMemberCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(imageView.snp.width).priority(.high)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(4)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(_ model: CastMemberModel) {
        nameLabel.text = model.name
        characterLabel.text = model.character
        guard let imageURL = model.imageURL else {
            imageView.image = UIImage(named: "human_placholder")
            return
        }
        imageView.kf.setImage(
            with: imageURL,
            placeholder: UIImage(named: "human_placholder"),
            options: nil,
            completionHandler: nil
        )
    }
}
