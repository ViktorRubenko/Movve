//
//  FavoriteTableViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 03.06.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let identifier = "FavoriteTableViewCell"
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = .appTextColor
        return label
    }()
    
    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .appSecondaryTextColor
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appSecondaryTextColor
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ratingFrontColor
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let votesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appSecondaryTextColor
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let dateAddedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appSecondaryTextColor
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.backgroundColor = .appCellBackground
        return view
    }()
    
    private let infoContainer = UIView()
    private let titleStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }()
    private let ratingVStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    private let bottomContainer = UIView()

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
        titleLabel.text = nil
    }
}

private extension FavoriteTableViewCell {
    func setupViews() {
        backgroundColor = .clear
        
        contentView.addSubview(container)
        container.addSubview(posterImageView)
        container.addSubview(infoContainer)

        infoContainer.addSubview(titleStackView)
        infoContainer.addSubview(releaseYearLabel)
        infoContainer.addSubview(genresLabel)
        infoContainer.addSubview(ratingVStackView)

        titleStackView.addArrangedSubview(titleLabel)
        ratingVStackView.addArrangedSubview(bottomContainer)

        bottomContainer.addSubview(ratingLabel)
        bottomContainer.addSubview(votesLabel)
        bottomContainer.addSubview(dateAddedLabel)
        
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(120).priority(.high)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(67)
        }
        
        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(posterImageView)
            make.bottom.equalTo(posterImageView)
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-5)
        }

        releaseYearLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.centerY)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        releaseYearLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(releaseYearLabel.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.centerY)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        genresLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        ratingVStackView.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        ratingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        votesLabel.snp.makeConstraints { make in
            make.leading.equalTo(ratingLabel.snp.trailing).offset(4).priority(.high)
            make.trailing.lessThanOrEqualTo(dateAddedLabel.snp.leading)
            make.centerY.equalTo(ratingLabel)
        }
        
        dateAddedLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(ratingLabel)
        }
    }
}

extension FavoriteTableViewCell {
    func configure(_ model: FavoriteModel) {
        titleLabel.text = model.title
        releaseYearLabel.text = model.releaseYear
        genresLabel.text = model.genres
        ratingLabel.text = "\(model.rating)"
        votesLabel.text = "\(model.votes)"
        dateAddedLabel.text = model.dateAdded
        
        guard let posterURL = model.posterURL else {
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
