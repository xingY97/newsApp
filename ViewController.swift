//
//  ViewController.swift
//  newsApp
//
//  Created by X Y on 1/8/21.
//

import UIKit

class ViewController: UIViewController, ArticleModelProtocol {

    var model = ArticleModel ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the articles from the article model
        model.delegate = self
        model.getArticles()
    }

    // MARK: - Article Model Protocol Methods
    func articlesRetrieved(_ articles: [Article]) {
        print("articles returned from model")
        
    }
}

