//
//  NewsDetailController.swift
//  Case-NewsApp
//
//  Created by Arslan Kaan AYDIN on 22.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class NewsDetailController: UIViewController {
    private let detailResult: Article
    
    private let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let newsDescriptonLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Visit the site", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    init(detailResult: Article) {
        self.detailResult = detailResult
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        loadUI()
        fetchData()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share(sender:)))
    }
    
    private func fetchData() {
        titleLabel.text = detailResult.title
        newsDescriptonLabel.text = detailResult.articleDescription
        guard let url = detailResult.urlToImage else { return }
        newsImage.kf.setImage(with: URL(string: url))
    }
    
    @objc func buttonTapped() {
        guard let url = detailResult.url else { return }
        guard let openUrl = URL(string: url) else { return }
        UIApplication.shared.open(openUrl)
    }
    
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        
        let textToShare = "Share the news"
        
        let objectsToShare = [textToShare] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = sender
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension NewsDetailController {
    private func loadUI() {
        
        view.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.width.equalTo(newsImage.snp.height)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(SnapKitPadding().pd4)
            make.centerX.equalTo(newsImage)
            make.left.equalToSuperview().offset(SnapKitPadding().pd16)
            make.right.equalToSuperview().inset(SnapKitPadding().pd16)
        }
        
        view.addSubview(newsDescriptonLabel)
        newsDescriptonLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(SnapKitPadding().pd12)
            make.right.left.equalTo(titleLabel)
        }
        
        view.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(SnapKitPadding().pd20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(SnapKitPadding().pd48)
            make.right.equalToSuperview().inset(SnapKitPadding().pd48)
            make.height.equalTo(SnapKitPadding().pd52)
        }
    }
}
