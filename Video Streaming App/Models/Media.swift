//
//  Media.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import Foundation

class Media{
    var movieName: String?
    var audienceType: String?
    var ratings: String?
    var thumbImage: String?
    var length: String?
    
    
    init(data: [String: Any]) {
        configure(data: data)
    }
    
    
    func configure(data: [String: Any]){
        if let value = data["movie-name"] as? String{
            movieName = value
        }
        
        if let value = data["audience-type"] as? String{
            audienceType = value
        }
        
        if let value = data["ratings"] as? String{
            ratings = value
        }
        
        if let value = data["thumb-image"] as? String{
            thumbImage = value
        }
        
        if let value = data["length"] as? String{
            length = value
        }
    }
}
