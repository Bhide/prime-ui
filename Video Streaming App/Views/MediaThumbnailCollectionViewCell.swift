//
//  MediaThumbnailCollectionViewCell.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import UIKit
import Kingfisher

class MediaThumbnailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaThumbnailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(media: Media){
        if let thumb = media.thumbImage{
            mediaThumbnailImageView.kf.setImage(with: URL(string: thumb), placeholder: UIImage(named: "media-placeholder"), options: [.cacheOriginalImage]) { (result, error) in
                
            }
        }
    }

}
