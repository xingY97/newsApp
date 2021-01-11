//
//  ViewController.swift
//  newsApp
//
//  Created by X Y on 1/8/21.
//

import UIKit

class ViewController: UIViewController {

    var model = ArticleModel ()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the articles from the article model
        model.delegate = self
        model.getArticles()
    }

}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articlesRetrieved(_ articles: [Article]) {
        
        //Set the articles property ofthe view controller to the articles pass back from model
        self.articles = articles
    }
}

