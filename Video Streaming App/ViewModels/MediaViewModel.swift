//
//  MediaViewModel.swift
//  Video Streaming App
//
//  Created by Samir on 4/2/22.
//

import Foundation
import Alamofire


/// Protocol for media load events.
protocol MediaDelegate: AnyObject{
    func mediaLoaded(mediaCategory: [MediaCategory]?, error: Error?)
}

class MediaViewModel{
    
    let mediaMetadataURL = "https://62472f17229b222a3fca01c6.mockapi.io/media-content"
    
    weak var delegate: MediaDelegate?
    
    /// Load media datas for dashboard
    func loadMediaData(){
        AF.request(mediaMetadataURL)
            .responseJSON { [weak self](response) in
                debugPrint("response: \(response)")
                
                guard let weakSelf = self else{return}
                
                if let error = response.error{
                    weakSelf.delegate?.mediaLoaded(mediaCategory: nil, error: error)
                }else{
                    if let responseJSONArray = response.value as? [[String: Any]]{
                        for resp in responseJSONArray{
                            if let data = resp["data"] as? [[String: Any]]{
                                for dataSet in data{
                                    var medias = [MediaCategory]()
                                    
                                    medias.append(MediaCategory(data: dataSet))
                                    weakSelf.delegate?.mediaLoaded(mediaCategory: medias, error: nil)
                                }
                            }
                            
                        }
                    }
                }
                
            }
    }
}
