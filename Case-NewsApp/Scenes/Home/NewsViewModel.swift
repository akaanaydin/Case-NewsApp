//
//  NewsViewModel.swift
//  Case-NewsApp
//
//  Created by Arslan Kaan AYDIN on 22.06.2022.
//

import Foundation
import Alamofire

protocol NewsViewModelProtocol {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchDetailArticle(onSuccess: @escaping (Article?) -> Void, onError: @escaping (AFError) -> Void)
}

final class NewsViewModel: NewsViewModelProtocol {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
}

extension NewsViewModel {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchArticles { article in
            guard let article = article else {
                onSuccess(nil)
                return
            }
            onSuccess(article)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchDetailArticle(onSuccess: @escaping (Article?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchDetailArticle { article in
            guard let article = article else {
                onSuccess(nil)
                return
            }
            onSuccess(article)
        } onError: { error in
            onError(error)
        }
    }
}
