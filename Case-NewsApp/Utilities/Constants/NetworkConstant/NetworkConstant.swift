//
//  NetworkConstant.swift
//  Case-NewsApp
//
//  Created by Arslan Kaan AYDIN on 23.06.2022.
//

import Foundation


extension Constant {
    class Network {
        
        enum ServiceEndPoint: String {
            
            case BASE_URL = "https://newsapi.org/v2/everything?q=apple&from=2022-06-17&to=2022-06-17&sortBy=popularity&"
            case API_KEY = "apiKey=476d05192e6c42e1b9ffacf403f3dbbe"
            
            static func fetchArticles() -> String {
                "\(ServiceEndPoint.BASE_URL.rawValue)\(ServiceEndPoint.API_KEY.rawValue)"
            }
        }
    }
}
