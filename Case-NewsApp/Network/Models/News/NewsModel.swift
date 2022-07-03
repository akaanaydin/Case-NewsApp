//
//  NewsModel.swift
//  Case-NewsApp
//
//  Created by Arslan Kaan AYDIN on 23.06.2022.
//

import Foundation

// MARK: - Welcome
struct ArticleList: Codable {
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
//    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}

