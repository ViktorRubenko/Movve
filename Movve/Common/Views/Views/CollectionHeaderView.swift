//
//  CollectionHeaderView.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "CollectionHeaderView"
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
