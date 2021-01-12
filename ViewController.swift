//
//  ViewController.swift
//  newsApp
//
//  Created by X Y on 1/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel ()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the viewController as the datasource and delegate of tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        //Get the articles from the article model
        model.delegate = self
        model.getArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Detect the indexpath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            //The user hasn't selected anything
            return
        }
        
        //Get the article the user tapped on
        let article = articles[indexPath!.row]
        
        //Get a refrence to a detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        //Pass the article url to the detail view controller
        detailVC.articleUrl = article.url!
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        //Get the article that the tableView is asking about
        let article = articles[indexPath.row]
        
        //customize it
        cell.displayArticle(article)
        
        //return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articlesRetrieved(_ articles: [Article]) {
        
        //Set the articles property ofthe view controller to the articles pass back from model
        self.articles = articles
        
        
        //Refresh the tableview
        tableView.reloadData()
    }
}

