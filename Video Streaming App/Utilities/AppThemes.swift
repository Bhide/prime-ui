//
//  AppThemes.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import Foundation
import UIKit

class AppThemes{
    
    // Singleton
    static let current = AppThemes()
    
    
    
    func getHeaderForTitle(titleString: String) -> UIView{
        let screenRect = UIScreen.main.bounds
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: 40))
        containerView.backgroundColor = .clear
        
        let headerLbl = UILabel(frame: CGRect(x: 16, y: 10, width: screenRect.size.width, height: 20))
        let attributedString = NSMutableAttributedString(string: titleString)
        
        containerView.addSubview(headerLbl)
        
        applyKernToAttributedString(attributedString: attributedString)
        
        headerLbl.attributedText = attributedString
        if #available(iOS 13.0, *) {
            headerLbl.textColor = UIColor.label
        } else {
            headerLbl.textColor = UIColor.black
        }
        
        headerLbl.font = UIFont.preferredFont(forTextStyle: .headline)//UIFont(name: ID123Fonts.FontFamily.HelveticaLight.rawValue, size: 12.0)
        return containerView
    }
    
    func applyKernToAttributedString(attributedString: NSMutableAttributedString){
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: NSNumber(value: 0.7), range: NSMakeRange(0, attributedString.length))
    }
    
}
