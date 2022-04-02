//
//  AppUtils.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import Foundation


class AppUtils{
    
    class func dataToArray(_ data:Data) -> [String: Any]?{
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any] else{
            return nil
        }
        return dict
        
    }
    
}
