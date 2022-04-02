//
//  CarouselCell.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import UIKit

class CarouselCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var medias: MediaCategory?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
    }
    
    
    func configureCollectionView(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "MediaThumbnailCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: CellIdentifiers.mediaThumbnailCellIdentifier)
    }
    
    func configureCell(mediaCategory: MediaCategory){
        medias = mediaCategory
        
        collectionView.reloadData()
    }
    
}

extension CarouselCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.mediaThumbnailCellIdentifier, for: indexPath) as? MediaThumbnailCollectionViewCell else{return UICollectionViewCell()}
        
        if let medias = medias{
            let media = medias.medias[indexPath.row]
            
            cell.configure(media: media)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let category = medias else{return 0}
        return category.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let category = medias else{return CGSize.zero}
        
        if let carouselType = category.displayPattern{
            if  carouselType == CarouselType.RECT_CELL.rawValue{
                let width = collectionView.bounds.size.width / 2
                return CGSize(width: width, height: width * 0.65)
            }else if carouselType == CarouselType.SQUARE_CELL.rawValue{
                return CGSize(width: collectionView.bounds.size.width * 0.4, height: collectionView.bounds.size.width * 0.4)
            }
        }
                
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width * 0.5625)
        
    }
    
}
