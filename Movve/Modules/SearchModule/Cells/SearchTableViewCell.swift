//
//  SearchTableViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 04.06.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appTextColor
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appSecondaryTextColor
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .appCellBackground
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
}

extension SearchTableViewCell {
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(container)
        container.addSubview(posterImageView)
        container.addSubview(nameLabel)
        container.addSubview(releaseLabel)
    }
    
    private func setupConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(50).priority(.high)
            make.width.equalTo(33)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.centerY)
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.centerY).offset(5)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(nameLabel)
        }
        
    }
    
    func configure(_ item: ItemModel) {
        nameLabel.text = item.name
        releaseLabel.text = item.releaseDate
        guard let posterURL = item.imageURL else {
            posterImageView.image = .posterPlaceholder
            return
        }
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(
            with: posterURL,
            placeholder: nil,
            options: nil) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.posterImageView.image = .posterPlaceholder
                }
            }
    }
}
