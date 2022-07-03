//
//  NewsHomeController.swift
//  Case-NewsApp
//
//  Created by Arslan Kaan AYDIN on 22.06.2022.
//

import UIKit
import SnapKit

protocol NewsOutput {
    func selectedNews(news: Article)
}

class NewsHomeController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = 200
        return tableView
    }()
    
    private let searchController: UISearchController = UISearchController()
    
    private lazy var newsResult = [Article]()
    private lazy var searchResult = [Article]()
    private let viewModel: NewsViewModelProtocol = NewsViewModel(service: Service())

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(tableView)
        
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, tintColor: .black, title: "News", preferredLargeTitle: true)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.Identifier.custom.rawValue)
        
        loadUI()
        fetchNews()
    }
    
    private func fetchNews() {
        viewModel.fetchArticles { [weak self] article in
            guard let articles = article?.articles else { return }
            self?.newsResult = articles
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } onError: { error in
            print(error)
        }
    }


}

extension NewsHomeController {
    private func loadUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewsHomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResult.count
        }else {
            return newsResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.Identifier.custom.rawValue) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .white
        if searchController.isActive {
            cell.fetchNewsModel(model: searchResult[indexPath.row])
        }else {
            cell.fetchNewsModel(model: newsResult[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchController.isActive {
            selectedNews(news: searchResult[indexPath.row])
        }else {
            selectedNews(news: newsResult[indexPath.row])
        }
    }
}

extension NewsHomeController: NewsOutput {
    func selectedNews(news: Article) {
            self.navigationController?.pushViewController(NewsDetailController(detailResult: news), animated: true)
    }
}

extension NewsHomeController: UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String) {
        searchResult = newsResult.filter({ (newsResult:Article) -> Bool in
            let titleMatch = newsResult.title?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return titleMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.count > 2 {
                filterContentForSearchText(searchText)
                tableView.reloadData()
            }else {
                tableView.reloadData()
            }

            }

    }
}
