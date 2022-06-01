//
//  VideoCollectionViewCell.swift
//  Movve
//
//  Created by Victor Rubenko on 01.06.2022.
//

import UIKit
import youtube_ios_player_helper

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    
    var isLoaded: Bool = false
    var videoID: String = "" {
        didSet {
            if !isLoaded {
                playerView.load(withVideoId: videoID, playerVars: ["playsinline": "0", "modestbranding": "1"])
                isLoaded = true
            } else {
                playerView.cueVideo(byId: videoID, startSeconds: 0)
            }
        }
    }
    
    var name: String? = nil {
        didSet {
            nameLabel.text = name
        }
    }
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appTextColor
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var playerView: YTPlayerView = {
        let player = YTPlayerView()
        player.isOpaque = false
        player.backgroundColor = .clear
        player.layer.cornerRadius = 10
        player.clipsToBounds = true
        return player
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(playerView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        playerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
