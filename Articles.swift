//
//  Articles.swift
//  newsApp
//
//  Created by X Y on 1/8/21.
//

import Foundation
//codeable turns images, objects into JSON format
//Decodeable turns JSON into images and objects

struct Article : Decodable{
    
    var author: String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
