//
//  OverviewCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class OverviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OverviewCollectionViewCell"
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .appSecondaryTextColor
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    var text: String? {
        didSet {
            overviewLabel.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OverviewCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(overviewLabel)
        
        overviewLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
