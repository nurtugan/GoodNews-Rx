//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Nurtugan Nuraly on 10/11/20.
//  Copyright © 2020 XFamily, LLC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsTableViewController: UITableViewController {
    
    private var articles: [Article] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    private func populateNews() {
        URLRequest.load(resource: ArticleList.all)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] articleList in
                guard let articles = articleList?.articles else { return }
                self.articles = articles
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ArticleTableViewCell
        cell?.titleLabel.text = article.title
        cell?.descriptionLabel.text = article.description
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
