//
//  Article.swift
//  GoodNews
//
//  Created by Nurtugan Nuraly on 10/11/20.
//  Copyright © 2020 XFamily, LLC. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String?
    let description: String?
}

struct ArticleList: Codable {
    let articles: [Article]
}

extension ArticleList {
    static var all: Resource<Self> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=39d45614961845678a569e30fb50dd15")!
        return Resource<Self>(url: url)
    }()
}
