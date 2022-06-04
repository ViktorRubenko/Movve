//
//  DiscoveredMovieCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import UIKit

class DiscoveredCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DiscoveredCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var setCorners = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        releaseDateLabel.text = nil
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if setCorners {
            setCorners = false
            imageView.layoutIfNeeded()
            imageView.layer.cornerRadius = imageView.bounds.height * 0.05
        }
    }
}

// MARK: - Methods -

extension DiscoveredCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(releaseDateLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(1.35).priority(.high)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(4)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(_ model: ItemModel) {
        nameLabel.text = model.name
        releaseDateLabel.text = model.releaseDate
        
        guard let imageURL = model.imageURL else {
            imageView.image = UIImage(systemName: "film")
            return
        }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: imageURL,
            options: nil) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.imageView.image = .posterPlaceholder
                }
            }
    }
}
