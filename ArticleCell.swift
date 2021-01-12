//
//  ArticleCell.swift
//  newsApp
//
//  Created by X Y on 1/11/21.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        //Clean up the cell before displaying the next article
        articleImageView.image = nil
        headlineLabel.text = ""
        
        //Keep a refrence to the article
        articleToDisplay = article
        
        //Set the headline
        headlineLabel.text = articleToDisplay?.title
        
        //download and display the image
        
        //check that the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        //create url string
        let urlString = articleToDisplay!.urlToImage!
        
        //check the cacheManager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            //There is image data, set the imageview and return
            articleImageView.image = UIImage(data: imageData)
            return
            
        }
        
        //craete the url
        let url = URL(string: urlString)
        
        //check that the url isnt nil
        guard url != nil else {
            print("Couln't create url object")
            return
        }
        //Get a URLSession
        let session = URLSession.shared
        
        //Create a datatask
        let dataTask = session.dataTask(with: url!) {(data, response, error) in
            
            //check that there were no errors
            if error == nil && data != nil {
                
                //save the data into cache
                CacheManager.saveData(urlString, data!)
                
                //Check if the url string that the dta task went off to download matches the article this cell is set to display
                
                if self.articleToDisplay!.urlToImage == urlString{
                    
                    DispatchQueue.main.async {
                        //display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                    }
                    
                }
            
            }//End If
            
        }//End data task
        
        //kick off the datatask
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
