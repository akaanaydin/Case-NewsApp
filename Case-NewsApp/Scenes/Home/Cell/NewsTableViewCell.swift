//
//  NewsTableViewCell.swift
//  Case-NewsApp
//
//  Created by Arslan Kaan AYDIN on 26.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    enum Identifier: String {
        case custom = "cellIdentifier"
    }
    //MARK: - UI Elements

    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    
    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let newsNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let newsNameDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        loadUI()
    }
    
    func fetchNewsModel(model: Article) {
        newsNameLabel.text = model.title
        newsNameDescription.text = model.articleDescription
        guard let url = model.urlToImage else { return }
        newsImage.kf.setImage(with: URL(string: url))
    }
    
}

extension NewsTableViewCell {
    private func loadUI() {
        contentView.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(SnapKitPadding().pd16)
            make.bottom.equalTo(contentView).inset(SnapKitPadding().pd16)
            make.left.equalTo(contentView).offset(SnapKitPadding().pd16)
            make.width.equalTo(contentView).multipliedBy(0.36)
        }
        
        contentView.addSubview(infoImage)
        infoImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(SnapKitPadding().pd12)
            make.width.equalTo(SnapKitPadding().pd20)
        }
        
        contentView.addSubview(newsNameLabel)
        newsNameLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.top)
            make.left.equalTo(newsImage.snp.right).offset(SnapKitPadding().pd12)
            make.right.equalTo(infoImage.snp.right).inset(SnapKitPadding().pd24)
        }
        
        contentView.addSubview(newsNameDescription)
        newsNameDescription.snp.makeConstraints { make in
            make.top.equalTo(newsNameLabel.snp.bottom).offset(SnapKitPadding().pd4)
            make.left.right.equalTo(newsNameLabel)
            make.bottom.equalTo(newsImage.snp.bottom)
        }
    }
}
