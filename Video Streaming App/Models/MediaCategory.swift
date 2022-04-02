//
//  MediaCategory.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import Foundation

enum CarouselType: String {
case FULL_WIDTH_CELL = "full-width-banner"
    case SQUARE_CELL = "square-tile-items"
    case RECT_CELL = "rectangular-width-banner"
}

class MediaCategory{
    var categoryTitle: String?
    var sequenceNumber = 0
    var displayPattern: String?
    
    var medias = [Media]()
    
    
    init(data: [String: Any]) {
        configure(data: data)
    }
    
    
    func configure(data: [String: Any]){
        if let value = data["section-title"] as? String{
            categoryTitle = value
        }
        
        if let value = data["serial-number"] as? NSNumber{
            sequenceNumber = value.intValue
        }
        
        if let value = data["carousel-type"] as? String{
            displayPattern = value
        }
        
        if let value = data["content"] as? [[String: Any]]{
            for media in value{
                medias.append(Media(data: media))
            }
        }
    }
}
