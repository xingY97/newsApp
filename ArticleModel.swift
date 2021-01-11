//
//  ArticleModel.swift
//  newsApp
//
//  Created by X Y on 1/8/21.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        //Fire off the request to the API
        
        //Create a string URL
        let stringUrl = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-12-11&sortBy=publishedAt&apiKey=17f2c3be36ae48b49111615afc3041e2"
        
        //Create a url object
        let url = URL(string: stringUrl
        )
        //check that it isn't nil
        guard url != nil else {
            print("couldn't create url object")
            return
        }
        
        //get the url session
        let session = URLSession.shared
        
        //create the data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check that there are no errors and that there is data
            if error == nil && data != nil {
                
                //attempt to parse JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    //parse the json into articleService
                    let articleService = try decoder.decode(ArticleService.self, from:data!)
                    
                    //Get the articles
                    let articles = articleService.articles!
                    
                    //pass it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                   
                }
                catch {
                    print("Error parsing the JSON")
                } //End if Di-catch block
                
            }//End if
            
        }//End Data Task
        
        //Start the data task
        dataTask.resume()
        
        //Parse the returned JSON into article instances and pass it back to the view controller with the protocol and delegate patttern
    }
}
